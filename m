From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Fix typos on pt_BR/gittutorial.txt translation
Date: Fri, 31 Jul 2009 11:30:31 -0700
Message-ID: <7vvdl8puwo.fsf@alter.siamese.dyndns.org>
References: <b8bf37780907292044i5ad7b879ueb5048447e4e5bb5@mail.gmail.com>
 <20090730145044.GA1727@vespa.holoscopio.com>
 <4A71C6A7.80008@drmicha.warpmail.net>
 <b8bf37780907301031iec37ef8i6b3db7a9eb21eb8b@mail.gmail.com>
 <20090731163341.GB10800@vespa.holoscopio.com>
 <b8bf37780907311011m232b68b7k2ba63a8ee7fc2322@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Carlos R. Mafra" <crmafra2@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: =?utf-8?Q?Andr=C3=A9?= Goddard Rosa <andre.goddard@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 20:30:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWwsS-0007yq-GM
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 20:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776AbZGaSak convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Jul 2009 14:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752498AbZGaSak
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 14:30:40 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52008 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbZGaSak (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 14:30:40 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6E7B51B237;
	Fri, 31 Jul 2009 14:30:40 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 606751B235; Fri,
 31 Jul 2009 14:30:33 -0400 (EDT)
In-Reply-To: <b8bf37780907311011m232b68b7k2ba63a8ee7fc2322@mail.gmail.com>
 (=?utf-8?Q?=22Andr=C3=A9?= Goddard Rosa"'s message of "Fri\, 31 Jul 2009
 14\:11\:24 -0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3FDF857A-7E00-11DE-BC21-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124591>

Andr=C3=A9 Goddard Rosa <andre.goddard@gmail.com> writes:

> @@ -230,14 +229,14 @@ $ git commit -a
>  ------------------------------------------------
>
>  neste ponto, os dois ramos divergiram, com diferentes mudan=C3=A7as =
feitas em
> -cada um.  Para unificar as mudan=C3=A7as feitas no experimental para=
 o
> +cada um. Para unificar as mudan=C3=A7as feitas no experimental para =
o
>  master, execute
>
>  ------------------------------------------------
>  $ git merge experimental
>  ------------------------------------------------
>
> -Se as mudan=C3=A7as n=C3=A3o conflitam, est=C3=A1 pronto.  Se existi=
rem conflitos,
> +Se as mudan=C3=A7as n=C3=A3o conflitarem, estar=C3=A1 pronto. Se exi=
stirem conflitos,
>  marcadores ser=C3=A3o deixados nos arquivos problem=C3=A1ticos exibi=
ndo o
>  conflito;
>

Hmm, this seems to be different from the below in

	s/conflitam/conflitarem/

but I do not speak the language, so....  help?

    >  ------------------------------------------------
    > @@ -230,14 +229,14 @@ $ git commit -a
    >  ------------------------------------------------
    >=20
    >  neste ponto, os dois ramos divergiram, com diferentes mudan=C3=A7=
as feitas em
    > -cada um.  Para unificar as mudan=C3=A7as feitas no experimental =
para o
    > +cada um. Para unificar as mudan=C3=A7as feitas no experimental p=
ara o
    >  master, execute
    >=20
    >  ------------------------------------------------
    >  $ git merge experimental
    >  ------------------------------------------------
    >=20
    > -Se as mudan=C3=A7as n=C3=A3o conflitam, est=C3=A1 pronto.  Se ex=
istirem conflitos,
    > +Caso as mudan=C3=A7as n=C3=A3o conflitam, est=C3=A1 pronto. Se e=
xistirem conflitos,

    I think the time tense here should be changed if we change from "Se=
" to
    "Caso". I'd rather keep "Se ... conflitam".
