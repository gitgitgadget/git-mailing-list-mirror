From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: error: hook declined to update refs/heads/master
Date: Mon, 21 Jul 2008 17:24:48 +0400
Message-ID: <37fcd2780807210624m4debee4en2dff4ab6bac0917d@mail.gmail.com>
References: <80F1AC38-8A10-4184-BBFB-870399DE9A3A@sikatizen.com>
	 <alpine.DEB.1.00.0807211153340.3305@eeepc-johanness>
	 <33E8E17B-D34A-4035-945A-CDB8A786A975@sikatizen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Jonathan Biolaz" <jonathan.biolaz@sikatizen.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 15:25:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKvOc-0006dH-Mm
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 15:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755116AbYGUNYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 09:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755133AbYGUNYt
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 09:24:49 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:33937 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755115AbYGUNYs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 09:24:48 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1593663wfd.4
        for <git@vger.kernel.org>; Mon, 21 Jul 2008 06:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=UvyPE05VpfwiuyDXGeqKgS3zS9HaQLASepD/AJTty4E=;
        b=qflNOlp7MfIkjvmgvkH4Fy01NFlExE2kRto1v8RzJWAWzpocz2ee1JG5AObxx0Vo3E
         o5+2L/qIfM4bhh2e04MvOB6cl48arWXmaR0oQ76CWOL7ANoxqOysIoXj1IZG/2D2x3jJ
         nYCzbV91gSe/qTzVi1GJJPlhitUyki4TtxZyI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=P6PxudTtdhutCF8WLd4jiKLq0JULUNuHhOSe9pI7qzzCrHG08660wRvO1wU1t7Poo8
         zr6MDDEMIy4RelwjMP8A71DpZl+reibluRddCUzRRSHGys/WQa1BPDDkdEEFkRIElJ1G
         JKLvxxKeZjedUD7MoTORcgcUlwe9hshe9K17k=
Received: by 10.142.162.9 with SMTP id k9mr1332224wfe.93.1216646688318;
        Mon, 21 Jul 2008 06:24:48 -0700 (PDT)
Received: by 10.142.106.16 with HTTP; Mon, 21 Jul 2008 06:24:48 -0700 (PDT)
In-Reply-To: <33E8E17B-D34A-4035-945A-CDB8A786A975@sikatizen.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89356>

On Mon, Jul 21, 2008 at 3:33 PM, Jonathan Biolaz
<jonathan.biolaz@sikatizen.com> wrote:
>
> So, what's a hook ?

http://www.kernel.org/pub/software/scm/git/docs/githooks.html

>  and how I set the description ??

By editing .git/description file.

Dmitry
