From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Fix typos on pt_BR/gittutorial.txt translation
Date: Thu, 30 Jul 2009 18:13:27 +0200
Message-ID: <4A71C6A7.80008@drmicha.warpmail.net>
References: <b8bf37780907292044i5ad7b879ueb5048447e4e5bb5@mail.gmail.com> <20090730145044.GA1727@vespa.holoscopio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-15?Q?Andr=E9_Goddard_Rosa?= <andre.goddard@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 18:14:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWYGX-0000ci-Ff
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 18:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbZG3QNp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Jul 2009 12:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbZG3QNo
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 12:13:44 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:56246 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751370AbZG3QNo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jul 2009 12:13:44 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id CADA53BDB74;
	Thu, 30 Jul 2009 12:13:43 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 30 Jul 2009 12:13:43 -0400
X-Sasl-enc: 0hS4sEwtlhFqWgcME0gydmMCGJ2KrDK4tVotNk3uISkd 1248970411
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6601C3C157;
	Thu, 30 Jul 2009 12:13:30 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.2pre) Gecko/20090728 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <20090730145044.GA1727@vespa.holoscopio.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124467>

Thadeu Lima de Souza Cascardo venit, vidit, dixit 30.07.2009 16:50:
> Thanks a lot for the review. I will apply it to my tree with some lit=
tle
> changes.
>=20
> On Thu, Jul 30, 2009 at 12:44:50AM -0300, Andr=E9 Goddard Rosa wrote:
=2E..
>> @@ -594,26 +590,26 @@ $ git log master..stable
>>  ir=E1 listar a lista de commits feitos no ramo "stable" mas n=E3o n=
o ramo
>>  "master".
>>
>> -O comando 'git-log' tem uma fraquza: ele precisa mostrar os commits=
 em
>> +O comando 'git-log' tem uma fraqueza: ele precisa mostrar os commit=
s em
>>  uma lista. Quando a hist=F3ria tem linhas de desenvolvimento que
>>  divergiram e ent=E3o foram unificadas novamente, a ordem em que 'gi=
t-log'
>> -apresenta essas mudan=E7as =E9 insignificante.
>> +apresenta essas mudan=E7as =E9 irrelevante.
>>
>> -A maioria dos projetos com m=FAltiplos contribuidores (como o kerne=
l
>> -linux, ou o git mesmo) tem unifica=E7=F5es frequentes, e 'gitk' faz=
 um
>> -trabalho melhor de visualizar sua hist=F3ria.  Por exemplo,
>> +A maioria dos projetos com m=FAltiplos contribuidores (como o kerne=
l do
>> +linux, ou o pr=F3prio git) tem unifica=E7=F5es frequentes, e 'gitk'=
 faz um
>> +trabalho melhor de visualizar sua hist=F3ria. Por exemplo,
>=20
> Sorry, but I could never accept "kernel do linux". I am deeply agains=
t
> this naming. It's "o kernel linux". It's like saying "kernel from lin=
ux"
> instead of "the linux kernel".
>=20

Isn't it more like "kernel of linux", which is pretty OK (at least in
English)?

Cheers,
Michael
