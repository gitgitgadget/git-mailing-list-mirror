From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: CR codes from git commands
Date: Thu, 22 Jan 2009 16:41:10 +0000
Message-ID: <e2b179460901220841h17c9eda2h38e8baff2964dac3@mail.gmail.com>
References: <18805.64312.289059.660023@hungover.brentg.com>
	 <alpine.LNX.1.00.0901212319310.19665@iabervon.org>
	 <e38bce640901212334v1e672d48t81d5c81fecd929eb@mail.gmail.com>
	 <alpine.LNX.1.00.0901220238380.19665@iabervon.org>
	 <7vbptzahra.fsf@gitster.siamese.dyndns.org>
	 <e2b179460901220204x7b6a43b5hddfee623d2425429@mail.gmail.com>
	 <18808.39712.351656.138702@hungover.brentg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 17:42:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ2dY-0004PX-4f
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 17:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753746AbZAVQlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 11:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753726AbZAVQlL
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 11:41:11 -0500
Received: from rv-out-0506.google.com ([209.85.198.236]:38059 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216AbZAVQlL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 11:41:11 -0500
Received: by rv-out-0506.google.com with SMTP id k40so4215845rvb.1
        for <git@vger.kernel.org>; Thu, 22 Jan 2009 08:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nWAf2yR5smrfT6DR2WtI9sYbRt0rV9RC/zXzPC8aA3o=;
        b=Y5qFW/TBZm03RG6uQ7YFkCgAYTbk1b/L8DRCfjHERtVQC6P4FJFVBbCiV4Q2kLu2J/
         TQvTD6o0LB5YKyw0kJmNedZzAfAGw23T4Ou4l0XnYlUkKMcXkrfj3PHSA/B+9Nobv56r
         18rC05vNw6sdxgMSGWDWBCZYt5pB6TjVBIKog=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tYyeXhbPtxFNZ7YkouygDYMGypcnYGtfyA3orvZ0p+k/2B/wzYCb0A5KMqkBAa/XZF
         si+B82PW7z/370J/uLRkgSTnSh8jk2qrIVHhk9omC9ZLvPlHVpkcAYINaSqBhkcSYCK0
         aYVUrVLw9MPYrfb0BQ4jF+qc7MqxcEWVhL9J8=
Received: by 10.140.139.4 with SMTP id m4mr31097rvd.32.1232642470164; Thu, 22 
	Jan 2009 08:41:10 -0800 (PST)
In-Reply-To: <18808.39712.351656.138702@hungover.brentg.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106763>

2009/1/22 Brent Goodrick <bgoodr@gmail.com>:
> Mike Ralphson writes:
>  > I think this earlier discussion is probably relevant... I'm guessing
>  > though, $EDITOR is set correctly here 8-)
>
> I do have EDITOR set to a home-built version of gnuclient...

Sorry, I was being too subtle. My $EDITOR is set to vim, as god intended. 8-)

Mike
