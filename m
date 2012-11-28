From: Marc Khouzam <marc.khouzam@gmail.com>
Subject: Re: [PATCH] Support for git aliasing for tcsh completion
Date: Tue, 27 Nov 2012 20:39:43 -0500
Message-ID: <CAFj1UpGipsewPRiumtuit5FKU2-CGMp3zgh48E3wdj=g4FWAOQ@mail.gmail.com>
References: <1353989472-4142-1-git-send-email-marc.khouzam@gmail.com>
	<CAFj1UpE5V5fKtt0fFOXLPrsQdOL8xpvzT=66Qi3=cMHit092Rg@mail.gmail.com>
	<7v38zvnez8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Tuncer Ayaz <tuncer.ayaz@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 02:40:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdWd6-0001vs-04
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 02:40:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755377Ab2K1Bjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 20:39:44 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:50332 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754552Ab2K1Bjo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 20:39:44 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so9328038iea.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 17:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IGU/+czaJXs/ztV1yUDlZrMBcEeuhrkSxvEGDodVGz4=;
        b=kxz+61knBJ8No6pO/7hclLsOv1pXzEt2TcPKIndYFEhGWyh/KTTF+anVSGAltZ5/rt
         430jeyRNWveRL6td3s9RVwbN3tuymHLNlT3ogkRLerdwkYy3eCAo2FfudlEZneQxcHAK
         5SmLl1M1020k0/zzGJhE8eYdQyZZGOD0Qndaesax/GRNMEPg143bPPdsmYdIsBr4JKf9
         V2CkVBxU8LVPFB7bftRpu73O3Ga7nULD8ckz/eSQ7S93RMvzIvDwa04T1OWGOktGdWdj
         agtvjG1CAqjPTGrSqoRoSUf8qTjkPiz2E4/ra4xaocNJ8/1R6zg97UWpfBXpJiJh7oxj
         RJ6Q==
Received: by 10.50.153.137 with SMTP id vg9mr20406192igb.40.1354066783865;
 Tue, 27 Nov 2012 17:39:43 -0800 (PST)
Received: by 10.64.132.39 with HTTP; Tue, 27 Nov 2012 17:39:43 -0800 (PST)
In-Reply-To: <7v38zvnez8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210658>

On Tue, Nov 27, 2012 at 12:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The patch was linewrapped so I had to fix it up;

Sorry about that.  I don't know if it is gmail, or the fact that I use
its web interface
that causes these problems.

> please double check
> what will be queued on 'pu' to make sure that I did not miss
> necessary whitespaces or added unnecessary ones when I rejoined long
> lines.

I just checked it and it looks great.

I'm working on another improvement to the script but I don't have it working
yet.  But I should not bother you much after that.

Thanks again!

Marc
