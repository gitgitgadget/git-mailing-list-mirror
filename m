From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Only run aggregate-results over actual counts
Date: Tue, 15 Jun 2010 23:44:30 +0200
Message-ID: <AANLkTil4HfoMPD4ds0uXRPruYrz4CtpAy-4TfEk0E_yT@mail.gmail.com>
References: <e10dd00b7a2064c71c9a509e2a7e82c935a60441.1276637243.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jun 15 23:45:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOdwP-0002dm-3p
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 23:45:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754727Ab0FOVov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 17:44:51 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57115 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754353Ab0FOVou (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 17:44:50 -0400
Received: by gwj15 with SMTP id 15so3624712gwj.19
        for <git@vger.kernel.org>; Tue, 15 Jun 2010 14:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=PitFaEdWcJgGfrInFLsTkrTpE2pXoR4TRTaw1t1rvYw=;
        b=fSS6B3J3jOBzA53duERRnSzl1vhoTOP15x/RWR7BLGLgKoq/suYIFoH8GTGjBLMGX7
         WBy+ajRWEL4Sd7HxxxFTZrupYbDS07Y35Z+/Ip8tIMZjzVlaGW/XzEpXVbvhD7RX7xNI
         FyhiBoVLHw5bpwQ9xIGeeVEiX2xNP3DEz2Utk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=GQENNibmgg9jo6NsObUoFt4jFrjill+zmGElwEpsWlgf15UKnggH8sA7in1WX/gMe0
         yyVw94XOhv0YG/SnqsrOlJdjm8m9M/KDd5plpkosqrm/fpOJDMaPBQiehjJaiX/dVDGA
         jGz6saK5hyjmqTFSqJvvjWvCK4IegfdOIYYXE=
Received: by 10.150.193.2 with SMTP id q2mr9372124ybf.114.1276638290094; Tue, 
	15 Jun 2010 14:44:50 -0700 (PDT)
Received: by 10.151.61.12 with HTTP; Tue, 15 Jun 2010 14:44:30 -0700 (PDT)
In-Reply-To: <e10dd00b7a2064c71c9a509e2a7e82c935a60441.1276637243.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149228>

Heya,

On Tue, Jun 15, 2010 at 23:36, Thomas Rast <trast@student.ethz.ch> wrote:
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>

Fwiw:

Acked-by: Sverre Rabbelier <srabbelier@gmail.com>

-- 
Cheers,

Sverre Rabbelier
