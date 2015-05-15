From: Dror Levy <DrorLevy@live.com>
Subject: RE: Bug when merging non normalized branch with normalized branch using the -X theirs -X renormalize options
Date: Fri, 15 May 2015 17:49:51 +0300
Message-ID: <DUB407-EAS33488F5B18766E047421E9EAEC70@phx.gbl>
References: <loom.20150515T153902-500@post.gmane.org> <loom.20150515T160501-69@post.gmane.org> <dba4955a359a93ff8fba2addc2de0e5a@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Johannes Schindelin'" <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 15 16:55:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtH0u-0003ot-R1
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 16:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934316AbbEOOy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 10:54:56 -0400
Received: from dub004-omc3s21.hotmail.com ([157.55.2.30]:64962 "EHLO
	DUB004-OMC3S21.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934155AbbEOOyz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 May 2015 10:54:55 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 May 2015 10:54:55 EDT
Received: from DUB407-EAS334 ([157.55.2.9]) by DUB004-OMC3S21.hotmail.com over TLS secured channel with Microsoft SMTPSVC(7.5.7601.22751);
	 Fri, 15 May 2015 07:49:52 -0700
X-TMN: [4pnC4FUeCp6a5946+2KKpA3GpX2utqnf]
X-Originating-Email: [drorlevy@live.com]
In-Reply-To: <dba4955a359a93ff8fba2addc2de0e5a@www.dscho.org>
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQABAgMEmTQBtE5f03qg8uaYA0DytaEcOGng
Content-Language: en-gb
X-OriginalArrivalTime: 15 May 2015 14:49:52.0891 (UTC) FILETIME=[66B89CB0:01D08F1E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269149>

The same happens with version 2.4.1.windows.1


Sent: 15 May 2015 17:35
Subject: Re: Bug when merging non normalized branch with normalized branch
using the -X theirs -X renormalize options

Hi,

On 2015-05-15 16:14, Dror Levy wrote:
> Using git version 1.9.5.msysgit.1

Please verify with Git for Windows 2.x (developers' preview) from
https://git-for-windows.github.io/ whether the problem persists.

Ciao,
Johannes
