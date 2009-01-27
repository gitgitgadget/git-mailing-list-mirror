From: Steven Noonan <steven@uplinklabs.net>
Subject: Re: Anyone have access to 64-bit Vista?
Date: Tue, 27 Jan 2009 15:01:06 -0800
Message-ID: <f488382f0901271501y2cf6dd84idc96e14aea1693e5@mail.gmail.com>
References: <83d7aaa40901270130g3bebb3d6we4839b567f310e46@mail.gmail.com>
	 <20090127122456.0df531c3.stephen@exigencecorp.com>
	 <83d7aaa40901271441h47c98edepc16f5026de636134@mail.gmail.com>
	 <alpine.DEB.1.00.0901272350360.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Geoffrey Lee <geoffreyj.lee@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 28 00:02:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRwxE-0003tF-Lu
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 00:02:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbZA0XBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 18:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbZA0XBI
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 18:01:08 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:13683 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbZA0XBH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 18:01:07 -0500
Received: by qw-out-2122.google.com with SMTP id 3so3232648qwe.37
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 15:01:06 -0800 (PST)
Received: by 10.214.80.1 with SMTP id d1mr5704516qab.288.1233097266264; Tue, 
	27 Jan 2009 15:01:06 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901272350360.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107416>

On Tue, Jan 27, 2009 at 2:51 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 27 Jan 2009, Geoffrey Lee wrote:
>
>> On Tue, Jan 27, 2009 at 10:24 AM, Stephen Haberman
>> <stephen@exigencecorp.com> wrote:
>> > It kind of works on my Vista 64-bit system--I do not see the shell
>> > extensions in the native Windows Explorer (which is 64 bit), but I do
>> > see the shell extensions in an Explorer replacement I use (Xplorer2)
>> > that is 32-bit.
>> >
>> > I've seen other oddities in 32-bit vs. 64-bit programs--e.g. my alt tab
>> > replacement (Joe), which is 32-bit, works great with 32-bit programs
>> > but cannot remove focus from 64-bit programs (IE, Windows Explorer,
>> > etc.). Ironically, very few of the programs I use are 64-bit, so I get
>> > by with the alt tab replacement.
>> >
>> > - Stephen
>> >
>>
>> Thanks! It seems that 64-bit explorer.exe will not load 32-bit shell
>> extensions. At least now I know I'm not going crazy. :)
>
> How could it?  You cannot have 32-bit code and 64-bit code running in the
> same process.  At least not with x86_64 (AFAIK).
>

Correct, this is also my biggest gripe with how x86_64 is implemented.
Thank you, AMD!

- Steven
