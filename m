From: Matthieu Imbert <matthieu.imbert@inria.fr>
Subject: Re: remote branches
Date: Sun, 13 Feb 2011 11:13:02 +0100
Message-ID: <4D57AEAE.9090406@inria.fr>
References: <4D578B6D.9090803@inria.fr>	<AANLkTi=WPAYXg1NCyO+XDw8Jk5v=QBH3nM78CEHytuVQ@mail.gmail.com> <m2wrl49rhg.fsf@whitebox.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 13 11:13:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoYx5-0003RH-Sq
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 11:13:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754146Ab1BMKNH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Feb 2011 05:13:07 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:10399
	"EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753985Ab1BMKNF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Feb 2011 05:13:05 -0500
X-IronPort-AV: E=Sophos;i="4.60,464,1291590000"; 
   d="scan'208";a="75843827"
Received: from sso69-1-88-163-193-142.fbx.proxad.net (HELO [192.168.1.3]) ([88.163.193.142])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-CAMELLIA256-SHA; 13 Feb 2011 11:13:03 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20101226 Icedove/3.0.11
In-Reply-To: <m2wrl49rhg.fsf@whitebox.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166655>

On 02/13/2011 11:08 AM, Andreas Schwab wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason<avarab@gmail.com>  writes:
>
>> Also because you specified --tags you're only getting the tags on "g=
it
>> fetch",
>
> That's not what git-remote(1) says:
>
>             With --tags option, git fetch<name>  imports every tag fr=
om the
>             remote repository.
>
> There is no "only" in this sentence.
>
> Andreas.

I agree, this is what misleaded me. Perhaps the doc should be updated?

--=20
Matthieu
