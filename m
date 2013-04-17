From: John Keeping <john@keeping.me.uk>
Subject: Re: "What's cooking" between #05 and #06
Date: Wed, 17 Apr 2013 09:40:37 +0100
Message-ID: <20130417084037.GQ2278@serenity.lan>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
 <7v8v4ihw41.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 10:40:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USNv8-0002Ev-IA
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 10:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965889Ab3DQIkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 04:40:45 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:54384 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965768Ab3DQIkn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 04:40:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 4E4C36065F7;
	Wed, 17 Apr 2013 09:40:43 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -11
X-Spam-Level: 
X-Spam-Status: No, score=-11 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uE-t1lrtaQRO; Wed, 17 Apr 2013 09:40:42 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 20320606565;
	Wed, 17 Apr 2013 09:40:39 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7v8v4ihw41.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221521>

On Tue, Apr 16, 2013 at 04:52:14PM -0700, Junio C Hamano wrote:
> > * jk/remote-helper-with-signed-tags (2013-04-15) 3 commits
> >  - transport-helper: add 'signed-tags' capability
> >  - transport-helper: pass --signed-tags=warn-strip to fast-export
> >  - fast-export: add --signed-tags=warn-strip mode
> 
> There were some comments on the noisiness of the warning output, but
> it appears that everybody involved in the area is basically happy
> with the direction this series goes in, so I'll expect a reroll and
> then merge it to 'next'.

What do you expect to change in the reroll?  The only comments I've seen
have been about the warning output it seems to me that we've agreed to
leave that as it is.  Have I missed something?
