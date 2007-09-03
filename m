From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: problem with git cvsimport
Date: Mon, 03 Sep 2007 13:28:37 +0200
Message-ID: <46DBEFE5.9020506@fs.ei.tum.de>
References: <A74F186F-7C25-48D5-9354-C74576439AF1@gmail.com> <5951BCFB-D3EF-4423-86F2-50F1D080721B@yahoo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?SmVhbi1GcmFuw6dvaXMgVmVpbGxldHRl?= 
	<jean_francois_veillette@yahoo.ca>
X-From: git-owner@vger.kernel.org Mon Sep 03 13:29:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISA71-0006dI-2G
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 13:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863AbXICL2l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 3 Sep 2007 07:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752330AbXICL2l
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 07:28:41 -0400
Received: from stella.fs.ei.tum.de ([129.187.54.7]:54191 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457AbXICL2k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 07:28:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 09A16289B6;
	Mon,  3 Sep 2007 13:28:39 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id YS13zZznPDeP; Mon,  3 Sep 2007 13:28:38 +0200 (CEST)
Received: from [128.178.149.21] (nslpc6.epfl.ch [128.178.149.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 0E9A2289B4;
	Mon,  3 Sep 2007 13:28:37 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <5951BCFB-D3EF-4423-86F2-50F1D080721B@yahoo.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57468>

Jean-Fran=C3=A7ois Veillette wrote:
> Again, any pointer is welcome to help resolve issues with importing c=
vs=20
> projects.
> Thanks to Michael for pointing out cvs2svn,I haven't tried it yet.

You might also want to give fromcvs/togit a try, which has been doing a=
=20
good job for me (obviously, since I wrote it for my own consumption).=20
Best try all converters and take the one conversion you like the most.=20
And report bugs/inconsistencies.

cheers
   simon
