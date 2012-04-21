From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: What's cooking in git.git (Apr 2012, #08; Fri, 20)
Date: Sat, 21 Apr 2012 12:23:35 +0200
Message-ID: <20120421102335.GA29660@goldbirke>
References: <xmqqobqmkkxv.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 12:23:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLXTm-0008M1-Rx
	for gcvg-git-2@plane.gmane.org; Sat, 21 Apr 2012 12:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753386Ab2DUKXj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Apr 2012 06:23:39 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:57282 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457Ab2DUKXi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2012 06:23:38 -0400
Received: from localhost6.localdomain6 (p5B13104A.dip0.t-ipconnect.de [91.19.16.74])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0M7A1q-1S02aU0ZDa-00x3lH; Sat, 21 Apr 2012 12:23:36 +0200
Content-Disposition: inline
In-Reply-To: <xmqqobqmkkxv.fsf@junio.mtv.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:ms2dU3qgJI1qXAi9sKC/PtRLLCfiIUiHjiFn9nIx6O4
 JuJh4Y+CCeD8cR2xMThWwEhhZBUd98Ik7KQllWGreN0j8XePVK
 1ve9DifINhF45N7CmCTDMrOPcKFap6R/LN7UHK1rA53qnYMNoh
 YHSChz3mmGy8Fz1lvht+cBcWNhH6+DJrvNnJFUUAoeHVjG7eJ+
 UXCXyhK17a33els3/1q2PJHP0bd333zi4cX3ItJia4YNy0Kq04
 vT4AUlIGRPK0DzdTib38GHF2nYNpNTTfPTmZk/3dnaRpVJDPNC
 AD0FrwA9uNSuXIahJkqtO1HB7/eiYUf6wBq249Ta3yzItyf9iv
 ZIpcuesBMYgCe9xMUNfk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196046>

Hi,

On Fri, Apr 20, 2012 at 05:06:20PM -0700, Junio C Hamano wrote:
> * fc/completion-tests (2012-04-18) 7 commits
>  - tests: add tests for the __gitcomp() completion helper function
>  - completion: fix completion after 'git --option <TAB>'
>  - completion: avoid trailing space for --exec-path
>  - completion: add missing general options
>  - completion: simplify by using $prev
>  - completion: simplify __gitcomp_1
>  - tests: add initial bash completion tests

Perhaps you could move 'tests: add tests for the __gitcomp()
completion helper function' from the top after 'tests: add initial
bash completion tests', to show that Felipe's 'completion: simplify
__gitcomp_1' doesn't break any of the tests.


Best,
G=E1bor
