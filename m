From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Bug when merging non normalized branch with normalized branch
 using the -X theirs -X renormalize options
Date: Fri, 15 May 2015 16:35:15 +0200
Organization: gmx
Message-ID: <dba4955a359a93ff8fba2addc2de0e5a@www.dscho.org>
References: <loom.20150515T153902-500@post.gmane.org>
 <loom.20150515T160501-69@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dror Levy <drorlevy@live.com>
X-From: git-owner@vger.kernel.org Fri May 15 16:35:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtGhx-00016W-0T
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 16:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbbEOOfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 10:35:20 -0400
Received: from mout.gmx.net ([212.227.17.20]:52139 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753971AbbEOOfT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 10:35:19 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MKLeM-1YrcHL06Sc-001lGq; Fri, 15 May 2015 16:35:17
 +0200
In-Reply-To: <loom.20150515T160501-69@post.gmane.org>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:mp3WGTQyYqXGW2MSYiuo9G7H/S8kS3BOt5a1gkoz3qWK43bBuN6
 OtE2EDk3Jm1lyWLU3eOpiGciV67d/FZMEPyogKVi+tj5RbznZpBt8PMbVYN03kwq5UHH2TU
 yYY/xM9InlzJVI3qydqekGVd06LaC0G+Qp91vpdi2MNNi2JRCMDBBAq3FYLv+3K3DkPyl5O
 pw7lGBki+Ie4F6vcjjCEQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269145>

Hi,

On 2015-05-15 16:14, Dror Levy wrote:
> Using git version 1.9.5.msysgit.1

Please verify with Git for Windows 2.x (developers' preview) from https://git-for-windows.github.io/ whether the problem persists.

Ciao,
Johannes
