From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] checkout: add a space between the commit and "..."
Date: Tue, 28 Sep 2010 16:34:14 -0700
Message-ID: <79D95DE3-74CB-4051-87D9-CBF363153ED0@sb.org>
References: <20100928222332.GA28859@soprano.nvidia.com> <tNUxsuXC1ZklaaYn-pkW6hae44B_tB2hStuto66EU4k9w2Q79GA6LQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Aaron Plattner <aplattner@nvidia.com>, git@vger.kernel.org,
	jkain@nvidia.com
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Sep 29 01:34:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0jgq-0004on-SU
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 01:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753639Ab0I1XeY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 19:34:24 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:65128 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910Ab0I1XeX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 19:34:23 -0400
Received: by pwi1 with SMTP id 1so54363pwi.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 16:34:23 -0700 (PDT)
Received: by 10.114.121.16 with SMTP id t16mr878557wac.169.1285716863419;
        Tue, 28 Sep 2010 16:34:23 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id r37sm13392009wak.23.2010.09.28.16.34.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Sep 2010 16:34:22 -0700 (PDT)
In-Reply-To: <tNUxsuXC1ZklaaYn-pkW6hae44B_tB2hStuto66EU4k9w2Q79GA6LQ@cipher.nrlssc.navy.mil>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157496>

On Sep 28, 2010, at 3:40 PM, Brandon Casey wrote:

> On 09/28/2010 05:23 PM, Aaron Plattner wrote:
>> Switching to a detached head prints something like
>> 
>>  HEAD is now at 9d14017... dir.c: squelch false uninitialized memory warning
>> 
>> These dots get selected when you double-click on the abbreviated
>> commit hash, which makes it annoying to copy and paste.
> 
> This must be another gnome-terminal/konsole "innovation".
> 
> xterm still does the "right thing"(tm) _and_ it doesn't eat my
> alt keystrokes like alt-b to move the cursor back a word. /rant

FWIW, Terminal.app on OS X also does the "right thing".

-Kevin Ballard