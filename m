From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Update Russian translation of git gui
Date: Mon, 27 Apr 2009 13:10:47 +0400
Message-ID: <20090427091047.GC15723@dpotapov.dyndns.org>
References: <20090426132139.GA30825@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 13:26:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyMs2-0000BG-Ly
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 11:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbZD0JLR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Apr 2009 05:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751882AbZD0JLQ
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 05:11:16 -0400
Received: from mail-qy0-f112.google.com ([209.85.221.112]:48373 "EHLO
	mail-qy0-f112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbZD0JLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 05:11:16 -0400
Received: by qyk10 with SMTP id 10so1343492qyk.33
        for <git@vger.kernel.org>; Mon, 27 Apr 2009 02:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=erW2d/MRJFGVUrMTRETMNy+RIJ14LRpbPzKT8/C3QdI=;
        b=ev644qZiIkvfp+wkZZmr/1k4QyTF/Bz53r07m3TVw6qpVFIErgVY3/AxMn+bRrjfe5
         5xXeEp3PkqF78hRzyFRmL8Aq30ehbL2MWDi31NJM37c6jzCY5NSo1AAl3hdzNnfhmkKb
         +aELhwAeWXFsevQylmkYtrnGA7mCaDuzvH+zc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=jBPrs2n+WWkSUeM/vdDKqe9/dHM2Ko5SanWM8uhntHfW0t1mmPKBdZxJLpV90fClaL
         zcMtuptIHQcbEEEjVujxtHj/GvJ3ytEDQyfPcqrDkbNcULLq+jkQVozr1sEa6TEmh7oT
         Q0FUevzcBn8SPfucPA9D5V88BjWqr+pFLQirw=
Received: by 10.224.54.132 with SMTP id q4mr5476783qag.221.1240823475124;
        Mon, 27 Apr 2009 02:11:15 -0700 (PDT)
Received: from localhost ([91.78.48.223])
        by mx.google.com with ESMTPS id 7sm6387986qwf.45.2009.04.27.02.11.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Apr 2009 02:11:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090426132139.GA30825@blimp.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117660>

On Sun, Apr 26, 2009 at 03:21:40PM +0200, Alex Riesen wrote:
> I also changed translation of the word 'tag': the old term was just a
> transliteration. There is a russian word with a fitting meaning and
> it is even used.

=D4=C1=C7 (which was used before) is certainly incorrect, but both "=D4=
=C5=C7" and
"=CD=C5=D4=CB=C1" are widely used in Russian. Though "=D4=C5=C7" may be=
 considered as
computer slang, so "=CD=C5=D4=CB=C1" is better for formal documentation=
=2E..

> -#: git-gui.sh:932
> +#: git-gui.sh:1076
>  msgid "Cannot use funny .git directory:"
>  msgstr "=EB=C1=D4=C1=CC=CF=C7.git =C9=D3=D0=CF=D2=DE=C5=CE: "
------------------^

Missing space before dot.

> -#: git-gui.sh:1606 git-gui.sh:1607 git-gui.sh:1608 git-gui.sh:1609
> +#: git-gui.sh:1838 git-gui.sh:1839 git-gui.sh:1840 git-gui.sh:1841
> +#: git-gui.sh:1842 git-gui.sh:1843
>  msgid "Requires merge resolution"
>  msgstr "=F4=D2=C5=C2=D5=C5=D4=D3=D1 =D2=C1=DA=D2=C5=DB=C5=CE=C9=C5 =CB=
=CF=CE=C6=CC=C9=CB=D4=C1 =D0=D2=C9 =CF=C2=DF=C5=C4=C9=CE=C5=CE=C9=C9"
> =20
> -#: git-gui.sh:1644
> +#: git-gui.sh:1878
>  msgid "Starting gitk... please wait..."
>  msgstr "=FA=C1=D0=D5=D3=CB=C1=C5=D4=D3=D1 gitk... =D0=CF=D6=C1=CC=D5=
=CA=D3=D4=C1, =D6=C4=C9=D4=C5..."

s/=D6=C4=C9=D4=C5/=D0=CF=C4=CF=D6=C4=C9=D4=C5/

"=D6=C4=C9=D4=C5" sounds somewhat impolite here...


> -#: git-gui.sh:1888
> +#: git-gui.sh:2316
>  msgid "Visualize Current Branch's History"
>  msgstr "=E9=D3=D4=CF=D2=C9=D1 =D4=C5=CB=D5=DD=C5=CA =D7=C5=D4=D7=C9 =
=CE=C1=C7=CC=D1=C4=CE=CF"

The Russian phrase lacks of the verb and the added adverb at the end
does not make much sense to me, so I would re-write the sentence as:

"=F0=CF=CB=C1=DA=C1=D4=D8 =C9=D3=D4=CF=D2=C9=C0 =D4=C5=CB=D5=DD=C5=CA =D7=
=C5=D4=D7=C9"

> =20
> -#: git-gui.sh:1892
> +#: git-gui.sh:2320
>  msgid "Visualize All Branch History"
>  msgstr "=E9=D3=D4=CF=D2=C9=D1 =D7=D3=C5=C8 =D7=C5=D4=D7=C5=CA =CE=C1=
=C7=CC=D1=C4=CE=CF"

"=F0=CF=CB=C1=DA=C1=D4=D8 =C9=D3=D4=CF=D2=C9=C0 =D7=D3=C5=C8 =D7=C5=D4=D7=
=C5=CA"

> -#: git-gui.sh:1901
> +#: git-gui.sh:2329
>  #, tcl-format
>  msgid "Visualize %s's History"
>  msgstr "=E9=D3=D4=CF=D2=C9=D1 =D7=C5=D4=D7=C9 %s =CE=C1=C7=CC=D1=C4=CE=
=CF"

"=F0=CF=CB=C1=DA=C1=D4=D8 =C9=D3=D4=CF=D2=C9=C0 =D7=C5=D4=D7=C9 %s"

> -#: git-gui.sh:2002 git-gui.sh:2389
> +#: git-gui.sh:2432
> +msgid "Done"
> +msgstr "=FA=D7=C5=D2=DB=C5=CE=CF"

spelling: "=FA=C1=D7=C5=D2=DB=C5=CE=CF"

> -#: git-gui.sh:2064
> +#: git-gui.sh:2518
>  msgid "Local Merge..."
>  msgstr "=EC=CF=CB=C1=CC=D8=CE=CF=C5 =CF=C2=DF=C5=C4=C9=CE=C5=CE=C9=C5=
=2E.."

"=D3=CC=C9=D1=CE=C9=C5" is a more common term for "merge" in Russian co=
mputer
literature though "=CF=C2=DF=C5=C4=C9=CE=C5=CE=C9=C5" is probably okay.=
=2E.


Dmitry
