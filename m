From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 00/18] Introduce an internal API to interact with the
 fsck machinery
Date: Wed, 21 Jan 2015 19:24:57 +0100
Organization: gmx
Message-ID: <e779d4655b61b33827026e2aa440536b@www.dscho.org>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1421682369.git.johannes.schindelin@gmx.de>
 <xmqq4mrkxzlb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 19:25:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDzxn-0001gE-5d
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 19:25:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbbAUSZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 13:25:07 -0500
Received: from mout.gmx.net ([212.227.17.20]:63357 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751484AbbAUSZF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 13:25:05 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LlV4F-1XcjT20eWd-00bKQZ; Wed, 21 Jan 2015 19:24:59
 +0100
In-Reply-To: <xmqq4mrkxzlb.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:lerGZ02q3zGf6nmwWnhCC2bzQZN4Zt39Cz/+3TcTB+QJrs0kD03
 bkAyoDXvTXqWKvlYFVk9hKUI5zLyI6ZYkEftAkKUFPIeoDD0/BPj8nsi6d0HEMFQi4TH79S
 FYyiFr86d14EWVypZVnDYU+VmYuXkGT5UmM4qcHiUga2Rbn3G3LbdgagAU8iSRKDHXaFJUa
 46BdSip9L31oCqVm6KIkQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262739>

Hi Junio,

On 2015-01-21 10:17, Junio C Hamano wrote:
> The documentation did not format well.  Tentatively I added the
> attached fix-up on top of the series before merging to 'pu'.
> 
>  [...]

Sorry for that! I have to admit that I did not even build the documentation :-( I incorporated your fixes into the respective patches.

Ciao,
Dscho
