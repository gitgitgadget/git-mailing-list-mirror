From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 0/7] refs backend preamble
Date: Tue, 21 Jul 2015 13:49:33 -0700
Message-ID: <xmqqpp3ltew2.fsf@gitster.dls.corp.google.com>
References: <1437493504-3699-1-git-send-email-dturner@twopensource.com>
	<55AEA998.60501@alum.mit.edu>
	<1437511404.30911.21.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 22:49:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHeTs-0000bl-Tg
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 22:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755362AbbGUUth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 16:49:37 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33636 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110AbbGUUtg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 16:49:36 -0400
Received: by pdbnt7 with SMTP id nt7so55385227pdb.0
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 13:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=rD0QTlJFBqq+XgcrB/GCDSnJPEZH/ticEf6m6ojYOfk=;
        b=0XX9mC98Bl63yycc6TdFBkk2cPfc2Mhzk2vqLv3Fjm7WhKIyE9DKPARdfAoFQKpcf5
         HlbHNxQ6poekCU+ovY7UA2n8iWFhve2JvnIi9XbhX7HACPy6bt9BBQu8X4TzOFEx+4Oy
         NmgaFMPP5TEs8w6dh3hZfTdOfjZpwagiTvogiNB3fUbOWm+vXIVALIQIGBGExTryvoXT
         QFi3s4f45SI2EB7DefEU1CDx8m8tV6F0ZMkMlAeS+si2Ce86XjHu39ACASppWrzmBA56
         X8xsPZSWc1PhdzTzPR2cvjwNuZM3x8b3F1m23RzXTKvv3RvvjzWIHJRUvtR1EVTzykDY
         I44Q==
X-Received: by 10.70.98.132 with SMTP id ei4mr61665670pdb.48.1437511776157;
        Tue, 21 Jul 2015 13:49:36 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3977:fdee:723a:a723])
        by smtp.gmail.com with ESMTPSA id w3sm29122846pdl.45.2015.07.21.13.49.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 21 Jul 2015 13:49:35 -0700 (PDT)
In-Reply-To: <1437511404.30911.21.camel@twopensource.com> (David Turner's
	message of "Tue, 21 Jul 2015 16:43:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274417>

David Turner <dturner@twopensource.com> writes:

> Junio, now that Michael has marked this as reviewed, do you want to pull
> from github, or do you want me to send a re-roll to the mailing list?

Let's see the final round; that would give me a chance to properly
sign-off your patch, and also give others a chance to eyeball them
for one last time.

Thanks.
