From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: git Dockerfile for ppc64le
Date: Mon, 31 Aug 2015 16:45:26 +0200
Organization: gmx
Message-ID: <b066c544c6597460f4e8f0c8be7cfe73@www.dscho.org>
References: <CAPS4ckqWociyEmph-mr3Ncz8J5genGjGPNu+sHsSviG5AKwu0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Gawade P <gawade.oefp@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 16:45:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWQKz-0006Xy-9E
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 16:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993AbbHaOp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 10:45:29 -0400
Received: from mout.gmx.net ([212.227.15.19]:56604 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752838AbbHaOp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 10:45:28 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M7pDs-1Yk72k3F2m-00vROc; Mon, 31 Aug 2015 16:45:26
 +0200
In-Reply-To: <CAPS4ckqWociyEmph-mr3Ncz8J5genGjGPNu+sHsSviG5AKwu0A@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:eEaZ/2oTg/5rrWH57fX9DMLAwV5mgp9nMmPiT8kAEMhGx3tgClc
 deC8Qkizx+NAVjy/SlZeqCJB4Z+tDJJ0NgbnqU/+bohbxIggkdB4U7wsGyYMgVyn3xP/RHg
 WeCLxscs3ueRn42uBA3027RWN9q5VpnFQZKrOpo7lX1ehSpj6QgRSSwbHXE40M9aneMbDcI
 FZB4dzdTkmNvSfSbKWy7g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zf+3ifAWjkc=:rARO9R/0ofqnyEYXsViFwf
 YbsW9vu1ES7g8O+3QLemz7GiTxvJjW2CQoKZBIdTqBgy689nGUyI4D0jLPf9qngznj3+dB4KJ
 LoHO65aHlvDezJT1Uv9k79bs71xe6M3TQ6noycdssA8QHd/42fDNZWiV45QVzcJV3JyeNnDVs
 YhVQ3feJlXTGJbGM18gmWIiOyz2nQHa9jS8SHg3h8rEBr73MTDd4fL1a7D/cfNmAuhy1J/G0L
 6Ajke/MBeAQqDuZVN6cvTjbzYos/N535q1e8O56TVE8f/oqe+/ffBIBC1QQI5AW8kIM1e8viN
 JzIH0nae+d8YsKjNwmVmwVjDzXzoSTaxzOlDlVoxWFdF+Y7oKV525CGTRtXszd6+jLx8dGkgM
 nneL9HiV74DeizoRg9TTyzPV5dnmB4YGsd8coqrMReWu5EpNNF/tItY7mFY9ichZR3RAsU9xl
 kjG6gGuLteM/cZ5xbuyCTZ/WxzSoVD17aXwP9dSt/TRGfUuFuggcKETsOLf87Cvibgf+5WJbb
 BCRCMDyW+h5D5ee8+oiNyukF7EsFKo1xFm0FT/ATO2tnPjld0sfC4e+p6PBt1L3c00t6Xlbov
 LSK6Wj+iuXJsmmvD7/c7RNwiE+zicS/MtSuPKJxsZNyrXbseDheH/5vPqsT2rCHpaYqUv1Q40
 WD7p7E9bXVsv7wmlDZe1JlEg/WfPB/GFQmQ38RoLbxwawI/f0DpzU4XScj6YT8wWpdX9vK/+a
 wdDQIycOWlQLKSX7i2sfkdKdP6is5g7kYo7d/Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276880>

Hi,

On 2015-08-25 06:37, Gawade P wrote:

> I have built and tested the latest version on git on multiple
> distributions including Ubuntu 15.04 on the ppc64le architecture. I
> have run the complete test suite and verified that there are no test
> failures.
> 
> I have also written a dockerfile for this for Ubuntu 15.04 and wanted
> to understand if there is any way I can contribute it to the git
> community?

Nice! As far as I understand, you could upload this to https://hub.docker.com/ and then everybody could benefit from a simple installation (something like `docker pull GawadeP/git/ppc64le`).

Ciao,
Johannes
