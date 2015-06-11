From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: proxy_windows_386.exe Firewall Notification
Date: Thu, 11 Jun 2015 22:43:05 +0300
Message-ID: <20150611224305.ac126629f69dbb915bdc8851@domain007.com>
References: <BLUPR0701MB196906E314F2F1083B5DEC2BD7BC0@BLUPR0701MB1969.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: BGaudreault Brian <BGaudreault@edrnet.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 21:43:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z38Nj-00065Q-T2
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 21:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653AbbFKTnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 15:43:14 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:49356 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111AbbFKTnN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 15:43:13 -0400
Received: from tigra.domain007.com ([192.168.2.102])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id t5BJh6wZ027216;
	Thu, 11 Jun 2015 22:43:07 +0300
In-Reply-To: <BLUPR0701MB196906E314F2F1083B5DEC2BD7BC0@BLUPR0701MB1969.namprd07.prod.outlook.com>
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271457>

On Thu, 11 Jun 2015 17:46:58 +0000
BGaudreault Brian <BGaudreault@edrnet.com> wrote:

> Hello, when connecting to a Vagrant Shared VM via SSH, I'm getting a
> Windows Firewall prompt about 'proxy_windows_386.exe' (in C:\Program
> Files\hashicorp\vagrant\embedded\gems\gems\vagrant-share-1.1.0
> \localbin\), which looks like a malware-type name.  Here's the
> message: "Windows Security Alert.  Windows Firewall has blocked some
> features of this app.  Windows Firewall has blocked some features of
> proxy_windows_386.exe on all public and private networks.".
> 
> So I did a quick search for this file name on the Internet as well as
> the Git-SCM.com/community site and haven't found any clear
> explinations about what this file is and if it's safe.  If this is a
> legitimate safe file, I think it's important that this is clearly
> documented in the Git documentation.  Can someone verify the details
> about this file?

I fail to get how did you manage to connect "proxy_windows_386.exe"
with Git.  Care to elaborate on this?
