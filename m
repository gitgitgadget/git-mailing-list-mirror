From: Nico Williams <nico@cryptonector.com>
Subject: Re: Sharing merge conflict resolution between multiple developers
Date: Mon, 11 Aug 2014 14:33:47 -0500
Message-ID: <CAK3OfOhASo7O8UY0xbRti1GCaaLe8nZTsNj5tBQpGYNwO77R5g@mail.gmail.com>
References: <CAFOYHZCiKC4TR4jFVUB=W5qbDG8XvB2Obx1ZfTH8OF3E_c5BnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 21:33:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGvLt-0003eP-DH
	for gcvg-git-2@plane.gmane.org; Mon, 11 Aug 2014 21:33:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754582AbaHKTdt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2014 15:33:49 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:58281 "EHLO
	homiemail-a49.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752825AbaHKTdt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Aug 2014 15:33:49 -0400
Received: from homiemail-a49.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a49.g.dreamhost.com (Postfix) with ESMTP id C9CE6200B9990
	for <git@vger.kernel.org>; Mon, 11 Aug 2014 12:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=
	mime-version:in-reply-to:references:date:message-id:subject:from
	:to:cc:content-type; s=cryptonector.com; bh=rN9UMU7KmQf9L7gpH7Me
	NRrP3NU=; b=UNUJoOUMXgqmu8HGNDC/yA8P9GuEiH5BCNPo3oxPM88JbGKxWfH6
	2lSrB5y5JUQsmuW2LUnE19D+CvTGsz2TGe91vg5bnX87neBVN1YhKc8XQzo+yTfk
	OQD+hBQrpVGgLRxtCakH13yYeNwn0f143vA1Ij68iwqnxJRhEbSxnug=
Received: from mail-wg0-f44.google.com (mail-wg0-f44.google.com [74.125.82.44])
	(using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by homiemail-a49.g.dreamhost.com (Postfix) with ESMTPSA id 58C8C200B998F
	for <git@vger.kernel.org>; Mon, 11 Aug 2014 12:33:48 -0700 (PDT)
Received: by mail-wg0-f44.google.com with SMTP id m15so8851155wgh.3
        for <git@vger.kernel.org>; Mon, 11 Aug 2014 12:33:47 -0700 (PDT)
X-Received: by 10.180.221.65 with SMTP id qc1mr28438404wic.28.1407785627128;
 Mon, 11 Aug 2014 12:33:47 -0700 (PDT)
Received: by 10.216.231.131 with HTTP; Mon, 11 Aug 2014 12:33:47 -0700 (PDT)
In-Reply-To: <CAFOYHZCiKC4TR4jFVUB=W5qbDG8XvB2Obx1ZfTH8OF3E_c5BnA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255134>

IIUC, this might help,

http://www.mail-archive.com/git@vger.kernel.org/msg56418.html
http://www.mail-archive.com/git@vger.kernel.org/msg56468.html
