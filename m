From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH] checkout: add a space between the commit and "..."
Date: Tue, 28 Sep 2010 17:40:11 -0500
Message-ID: <tNUxsuXC1ZklaaYn-pkW6hae44B_tB2hStuto66EU4k9w2Q79GA6LQ@cipher.nrlssc.navy.mil>
References: <20100928222332.GA28859@soprano.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jkain@nvidia.com
To: Aaron Plattner <aplattner@nvidia.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 00:40:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0iqU-0005Jw-Qj
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 00:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846Ab0I1WkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 18:40:16 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:53690 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941Ab0I1WkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 18:40:16 -0400
Received: by mail.nrlssc.navy.mil id o8SMeCIm014686; Tue, 28 Sep 2010 17:40:12 -0500
In-Reply-To: <20100928222332.GA28859@soprano.nvidia.com>
X-OriginalArrivalTime: 28 Sep 2010 22:40:12.0207 (UTC) FILETIME=[1CA103F0:01CB5F5E]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157494>

On 09/28/2010 05:23 PM, Aaron Plattner wrote:
> Switching to a detached head prints something like
> 
>   HEAD is now at 9d14017... dir.c: squelch false uninitialized memory warning
> 
> These dots get selected when you double-click on the abbreviated
> commit hash, which makes it annoying to copy and paste.

This must be another gnome-terminal/konsole "innovation".

xterm still does the "right thing"(tm) _and_ it doesn't eat my
alt keystrokes like alt-b to move the cursor back a word. /rant

-Brandon
