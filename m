From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] config.txt: stick to CamelCase naming convention
Date: Tue, 10 Mar 2015 15:11:10 +0100
Message-ID: <54FEFB7E.4020209@web.de>
References: <1425983981-634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 10 15:11:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVKsa-0002T7-AW
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 15:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753119AbbCJOLX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Mar 2015 10:11:23 -0400
Received: from mout.web.de ([212.227.15.3]:54120 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752448AbbCJOLX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 10:11:23 -0400
Received: from birne.local ([217.211.68.12]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0MGARb-1YGiAO0cJ5-00FBfT; Tue, 10 Mar 2015 15:11:15
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <1425983981-634-1-git-send-email-pclouds@gmail.com>
X-Provags-ID: V03:K0:OlYlp8j713A3bIZBgVZS+4b7c0re+VOm3QFXuvlAYKpuDv3rD5j
 YhmGhqnCg137bnZA/YGlCAbcldhg7VA+tBeUpspcsd/azO9o4zTV2lx8qCEpRYYPBmVs0vI
 oCxSMFo8nNUmS92EGUD5fCI1wbolLx7gS7YDx85arlnHw8oy3eOWVZYCFWn/Xslc3TDhkFe
 oTe1vhRcBbwJ30NzbRnAg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265239>

On 10.03.15 11:39, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  .. while I'm looking at config.txt. I think this is the preferred na=
ming
>  convention for config keys.=20

I think the default is unix-like lowercase,
this is what Git itself produces.=20
(core.ignorecase, core.filemode, core.precomposeunicode)
