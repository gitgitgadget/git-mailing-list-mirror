From: Bill Lear <rael@zopyra.com>
Subject: Re: split up a repository
Date: Wed, 3 Mar 2010 08:04:32 -0600
Message-ID: <19342.27760.544227.835077@blake.zopyra.com>
References: <20100302011226.76fda85d@gmail.com>
	<fabb9a1e1003020240h81f3e99wea1185c080a03b0@mail.gmail.com>
	<20100303002132.5df20326@gmail.com>
	<32541b131003021740n32535fbbh802af418ea0898aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Levente Kovacs <leventelist@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 03 15:04:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmpC4-0000qe-4d
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 15:04:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754328Ab0CCOEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 09:04:51 -0500
Received: from 75-27-130-60.lightspeed.austtx.sbcglobal.net ([75.27.130.60]:36951
	"HELO blake.zopyra.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1754205Ab0CCOEu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 09:04:50 -0500
Received: (qmail 17286 invoked by uid 500); 3 Mar 2010 14:04:34 -0000
In-Reply-To: <32541b131003021740n32535fbbh802af418ea0898aa@mail.gmail.com>
X-Mailer: VM 8.1.0-beta under 23.1.1 (i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141453>

On Tuesday, March 2, 2010 at 20:40:57 (-0500) Avery Pennarun writes:
>On Tue, Mar 2, 2010 at 6:21 PM, Levente Kovacs <leventelist@gmail.com> wrote:
>> On Tue, 2 Mar 2010 11:40:41 +0100
>> Ok. Really newbie question here. Just before I start to mess up my
>> repositories. I've cloned the git-subtree, and the install script would put
>> the script into /usr/lib/git-core. Is there any way to install the script
>> somewhere under /usr/local ?
>
>The actual function of git-subtree is one single file....

Does git-subtree support branching of the "main" repository and
sub-trees in coordinated (one step) fashion?


Bill
