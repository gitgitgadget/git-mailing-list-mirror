From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: What's cooking in git.git (Apr 2014, #02; Mon, 7)
Date: Tue, 08 Apr 2014 20:35:02 +0200
Message-ID: <53444156.8020800@web.de>
References: <xmqqmwfwlr4f.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 08 20:35:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXart-0006AH-ER
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 20:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757482AbaDHSfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 14:35:07 -0400
Received: from mout.web.de ([212.227.17.12]:54883 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756894AbaDHSfF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 14:35:05 -0400
Received: from [192.168.178.41] ([79.193.64.34]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0LqDTc-1XBLWR18Uq-00dlux; Tue, 08 Apr 2014 20:35:03
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <xmqqmwfwlr4f.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:5OqIHDe+yD9M5GizQKAyUyKBunWFrqrjDEFWUmX/G4Ii4CQkcwS
 0b9/XCe5m5G9mElE2TKjnWB+sHii6JSF/J+EuJoha7gOoAfYb/ChJQ/SKis5+1x/F7EX7U7
 PUDETnCZpGWH2qGxiTIkBYip7Wmn1KVOvzzzHrgWhiNku804+mZr8zpO/hAz475hkxOGrUW
 NQlbJdH+lwkf2sTq5cDbw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245942>

Am 08.04.2014 00:19, schrieb Junio C Hamano:
> * jl/status-added-submodule-is-never-ignored (2014-04-07) 2 commits
>  - commit -m: commit staged submodules regardless of ignore config
>  - status/commit: show staged submodules regardless of ignore config

I have two more patches for gitk and git-gui doing the same there,
me thinks it would make a lot of sense all four make it into the
same version. Should I wait until this topic hits next (or master)
or does it make sense to send them to Pat and Paul right away?
