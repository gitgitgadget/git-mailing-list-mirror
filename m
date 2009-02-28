From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] gitk: make use of themed widgets where available
Date: Sat, 28 Feb 2009 01:47:39 +0100
Message-ID: <fabb9a1e0902271647n36152700p101a92d793dabb41@mail.gmail.com>
References: <87ljrre7nr.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, paulus@samba.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Feb 28 01:49:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdDOO-0000PS-4Y
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 01:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754866AbZB1Aro convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Feb 2009 19:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754532AbZB1Aro
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 19:47:44 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:65363 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754785AbZB1Arn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Feb 2009 19:47:43 -0500
Received: by fxm24 with SMTP id 24so1295327fxm.37
        for <git@vger.kernel.org>; Fri, 27 Feb 2009 16:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5oPyI26ADPmnrAs7wSKpf0l7lNK7gSIg1rendMQ+v88=;
        b=ZG6YDhqu1+VnUnGccBmwr2PLYU0FB42bRUlxeiBNe1VYVOY2dfR680XUfXoqIWaATO
         hy4oTv+W9fq5t5hwo/fbcHIhZp9V4zyJ+67C+xfb5nGLjP0gEq7ONqltiHI6gIvc3tfT
         tOMq64SvwYAtYQedLszxFCPjowNGZnCsonkdA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SrvXnnBdWgwJJ/dJaokSrmChdFpxQuEZR6b05dL9QLPM6RRO+zn8rftd1c8UsLI+Rn
         HXO5MUgC9dLD/1nZXOKMVyVVQ32U3cBN97rdflRRFxdoaWDDbhLpnsvASMUvtf67bqB2
         CPvrgA76WKVlJKpvKuSm3wzQ0l7Ggu188xGuM=
Received: by 10.103.24.17 with SMTP id b17mr1616880muj.21.1235782060052; Fri, 
	27 Feb 2009 16:47:40 -0800 (PST)
In-Reply-To: <87ljrre7nr.fsf@users.sourceforge.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111730>

Heya,

On Sat, Feb 28, 2009 at 01:18, Pat Thoyts
<patthoyts@users.sourceforge.net> wrote:
> =A0 =A0This patch improves the appearence of gitk on Windows XP and V=
ista
> =A0 =A0by making use of the themed widgets that are provided in Tk 8.=
5
> =A0 =A0and above. For good Vista support 8.6 will be needed.

Screenies with before/after? :D

--=20
Cheers,

Sverre Rabbelier
