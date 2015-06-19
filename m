From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Bug report: Unhandled Exception
Date: Fri, 19 Jun 2015 14:58:39 +0200
Organization: gmx
Message-ID: <d13c20eaeeed4fefe6a7911bc08ea59f@www.dscho.org>
References: <DM2PR06MB4936C92C10128BD37E4ABC1D1BC0@DM2PR06MB493.namprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Gary England <GEngland@myvrx.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 14:58:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5vsh-00029O-GX
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 14:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001AbbFSM6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 08:58:43 -0400
Received: from mout.gmx.net ([212.227.15.18]:58415 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751494AbbFSM6l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 08:58:41 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MEXHd-1ZLdBO46Pp-00Fl9j; Fri, 19 Jun 2015 14:58:40
 +0200
In-Reply-To: <DM2PR06MB4936C92C10128BD37E4ABC1D1BC0@DM2PR06MB493.namprd06.prod.outlook.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:WdfnI0Nj+Nxk2nL4K0GECFw5w256cwLE777jbVn5atN3FomUOWS
 7lu5J6HKUTptAJ+AhpsbvHdRpvUihAz3WL//uBXv0XFlIeLTsEFUf5jvRX/qndN+gyVz8IX
 B4pMJjNVSxslgt3RF+fij8y38OYj+LU4ThufDK5ZMY8xOSh494MPZT9Seo5X8/fR/LWrfzR
 dRvaC1rCShOuAdorasVwQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272134>

Hi Gary,

On 2015-06-11 21:21, Gary England wrote:

> Using git version 1.9.2-preview20140411, in Git Bash for Windows,
> performing a "git pull --rebase", received an unhandled exception.

Please note that the newest 1.9.x release is 1.9.5. Could you re-test with that version, please? Or maybe you want to give the 2nd release candidate of Git for Windows 2.x a try: https://git-for-windows.github.io/#download

Ciao,
Johannes
