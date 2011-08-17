From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 7/7] sequencer: Remove sequencer state after final commit
Date: Thu, 18 Aug 2011 01:53:07 +0530
Message-ID: <CALkWK0nKiVdeGe2Q9pHA1JO1jyXMomjMpO8f5FqmmgXOEvOwmQ@mail.gmail.com>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
 <1313310789-10216-8-git-send-email-artagnon@gmail.com> <20110814160440.GK18466@elie.gateway.2wire.net>
 <7vei0nn1cn.fsf@alter.siamese.dyndns.org> <20110814213200.GA6555@elie.gateway.2wire.net>
 <7vippzlj7a.fsf@alter.siamese.dyndns.org> <7v7h6eld2c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 17 22:23:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtmeE-0001wc-Mk
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 22:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753801Ab1HQUX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 16:23:29 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62453 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727Ab1HQUX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 16:23:28 -0400
Received: by wwf5 with SMTP id 5so1375337wwf.1
        for <git@vger.kernel.org>; Wed, 17 Aug 2011 13:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BO9CbG8RTqREoUyaVMPsUEG5SHNMQHg8wKzlTJBwEYQ=;
        b=LcGOFajSornPvKLMLqWGb5g+EahaAnMd8HuIqZ5r4+fDCYFq6GZPwX4cncWtHNvD6p
         9PnuVlX4qtDaMRyBXxCrlY7Stsvhm+MuaZbCMWf4qJkorH/dz6LvQDTqNVVubnsyv0DJ
         ea0HNB7sWbert14MxW3/07jP3GChUc91ZkZlM=
Received: by 10.216.131.134 with SMTP id m6mr1176593wei.78.1313612607140; Wed,
 17 Aug 2011 13:23:27 -0700 (PDT)
Received: by 10.216.172.132 with HTTP; Wed, 17 Aug 2011 13:23:07 -0700 (PDT)
In-Reply-To: <7v7h6eld2c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179534>

Hi Junio,

Junio C Hamano writes:
> After sleeping on this, here are my random thoughts on this topic.

They're a bit much for me to absorb so quickly.  I'll think about this
again before posting a more elaborate reply.

Thanks for your patience.

-- Ram
