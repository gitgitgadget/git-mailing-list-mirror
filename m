From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Compatibility between git.git and jgit
Date: Fri, 1 May 2009 20:40:09 -0500
Message-ID: <b4087cc50905011840j664710f9xbb377f1578dfab5a@mail.gmail.com>
References: <20090415182754.GF23644@curie-int>
	 <alpine.LFD.2.00.0904151443030.6741@xanadu.home>
	 <7vy6tj109a.fsf@gitster.siamese.dyndns.org>
	 <alpine.LFD.2.00.0905011616130.6741@xanadu.home>
	 <7v4ow4v0xl.fsf@gitster.siamese.dyndns.org>
	 <20090502000123.GF23604@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat May 02 03:40:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M04DN-0005A7-6t
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 03:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbZEBBkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 21:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751820AbZEBBkL
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 21:40:11 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:45290 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbZEBBkK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 21:40:10 -0400
Received: by qyk34 with SMTP id 34so3894062qyk.33
        for <git@vger.kernel.org>; Fri, 01 May 2009 18:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NUWWh4Wx7VV7Xoy+silVdv8BQqDM3Hxo52eGRFxkRt8=;
        b=HLn3gmGSYSsG8caalP+nK2Bst8qRoZYyPdsbRyoOjxTs1SIm2+qQIcBEDq3KwbPP7P
         kxlxJFUdMrn0pv7EF3r8CRNH1GxvWdE53WmEbXTdlAXggVkrOnPzmJSo+EYzfwLZlP1U
         UaJb7PpbXDnHwQpDQIIz2RBLhgccVJnEi7y/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=h6SYdZHNratHqgXJsymuB32sU/oYEz60LaaszC8bXv4jYPvy8Tx/BWeY3iS107GvEK
         oXkCZ0KNSxIvGH98JodY5a50kdI2QWRf9yHpIAjlylY1jxpaPW3AJKDYX+2JJ8OcvUxJ
         pcel6FiQmFGGtAJMkX+Z4aABF6xiAPpJcVrlU=
Received: by 10.224.10.208 with SMTP id q16mr3843955qaq.387.1241228409304; 
	Fri, 01 May 2009 18:40:09 -0700 (PDT)
In-Reply-To: <20090502000123.GF23604@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118116>

On Fri, May 1, 2009 at 19:01, Shawn O. Pearce <spearce@spearce.org> wrote:
>
> But I think in another 12 months we'll be seeing people running
> only JGit in many contexts, making compatibility between the two
> implementations somewhat more important than it has been in the past.

:-D

Getting a little cocky there, eh Shawn?

Interestingly, you don't say "making compatibility **with git.git**
more important"...

Watch your back Junio!

:-D
