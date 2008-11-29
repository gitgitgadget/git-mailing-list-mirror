From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH 1/2] gitweb: add patch view
Date: Sat, 29 Nov 2008 17:50:46 +0100
Message-ID: <bd6139dc0811290850r404da348yda5dd5f1eb5dc95c@mail.gmail.com>
References: <1227966071-11104-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1227966071-11104-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <bd6139dc0811290743s6cf8e534nddd8a09698ea22b9@mail.gmail.com>
	 <200811291710.27891.jnareb@gmail.com>
	 <cb7bb73a0811290848j1b77fe89m66ead7cc4f5ca2bb@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org,
	"Petr Baudis" <pasky@suse.cz>, "Junio C Hamano" <gitster@pobox.com>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 29 17:52:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6T36-00016k-Pr
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 17:52:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308AbYK2Qus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 11:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752006AbYK2Qus
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 11:50:48 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:50148 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908AbYK2Qur (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 11:50:47 -0500
Received: by yw-out-2324.google.com with SMTP id 9so706985ywe.1
        for <git@vger.kernel.org>; Sat, 29 Nov 2008 08:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=1XvePicEC1+gw4/bInnXrzhjoUKZQWhasFHbcfFBjZY=;
        b=c/cP8v3CdT5fSF2Z/fBap471cYcdEwTNQhckEFRGDroIyCTdhkMlCoPOhMztpqWtw8
         HhVkUZzS9UP9e+t+Pum9uXq3orZRwwi4qdh1N0QGwg+RJf82z09tLMC3U2i+JXZMMi5G
         PkbQuJY4+UIzGWXlWQm6iVMvsXKDUz5cFGhaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=aWNCzP4JR3rxnU+ZCzOc59UGqTJATt540HzBG1GVlCyy8KEyaha99rrdQj9r2qVPlW
         2ADwJ69rwTIq6t3gizyAk6BsCCymsDPyvp9jd9HVH+p7I7m3Xk1jgA3wdxt3lcPS07yb
         tR23APVrLdN5AgViCVkb8ddgs09lQnBiFx254=
Received: by 10.151.78.15 with SMTP id f15mr5614992ybl.148.1227977446663;
        Sat, 29 Nov 2008 08:50:46 -0800 (PST)
Received: by 10.151.108.18 with HTTP; Sat, 29 Nov 2008 08:50:46 -0800 (PST)
In-Reply-To: <cb7bb73a0811290848j1b77fe89m66ead7cc4f5ca2bb@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101919>

On Sat, Nov 29, 2008 at 17:48, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
> Also, I was in doubt about the name for the new view, and I did
> consider 'patchset' (which you mention in your email). I chose to
> stick with the shorter form in the end, since many people complain
> that gitweb already produces paths that are too long.

Heh, what do I care about the length of the url, there's so many url
shorteners out there, that's not really a problem to me :).

-- 
Cheers,

Sverre Rabbelier
