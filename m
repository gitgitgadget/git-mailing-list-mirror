From: Mark A Rada <marada@uwaterloo.ca>
Subject: Re: Add Gitweb support for LZMA compressed snapshots
Date: Sat, 1 Aug 2009 12:07:56 -0400
Message-ID: <CC0DDAD1-D61F-465F-9533-95A101C61522@uwaterloo.ca>
References: <E0C39B59-E2C5-4C28-9570-D33FEA2A44EB@uwaterloo.ca> <m3r5vy1siq.fsf@localhost.localdomain> <alpine.DEB.1.00.0907301042300.7467@intel-tinevez-2-302> <94a0d4530907310845k51dbafbfy8e240467113dfc16@mail.gmail.com> <alpine.DEB.1.00.0908011431060.8306@pacific.mpi-cbg.de> <94a0d4530908010610n31261414yc08060f3de9c115f@mail.gmail.com> <40aa078e0908010704k7581b656h1ed98a8852efa445@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Aug 01 18:08:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXH84-0006kr-AV
	for gcvg-git-2@gmane.org; Sat, 01 Aug 2009 18:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbZHAQII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2009 12:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751849AbZHAQII
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 12:08:08 -0400
Received: from services10.student.cs.uwaterloo.ca ([129.97.152.18]:47537 "EHLO
	services10.student.cs.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751675AbZHAQIH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Aug 2009 12:08:07 -0400
Received: from [192.168.1.102] (CPE0018397ddc22-CM001225dfe86e.cpe.net.cable.rogers.com [174.117.223.147])
	(authenticated bits=0)
	by services10.student.cs.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id n71G81UH001719
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 1 Aug 2009 12:08:04 -0400 (EDT)
In-Reply-To: <40aa078e0908010704k7581b656h1ed98a8852efa445@mail.gmail.com>
X-Mailer: Apple Mail (2.935.3)
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (services10.student.cs.uwaterloo.ca [129.97.152.13]); Sat, 01 Aug 2009 12:08:04 -0400 (EDT)
X-Miltered: at mailchk-m01 with ID 4A746861.002 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.1 at mailchk-m02
X-Virus-Status: Clean
X-UUID: 04fe34c7-82a1-45ee-8068-19c40d1b0759
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124635>

On 1-Aug-09, at 10:04 AM, Erik Faye-Lund wrote:

> On Sat, Aug 1, 2009 at 3:10 PM, Felipe
> Contreras<felipe.contreras@gmail.com> wrote:
>> Windows can't extract .tar.gz?
>
> Not without installing 3. party software. Zip-support is built into
> the operating system.
>
> -- 
> Erik "kusma" Faye-Lund
> kusmabite@gmail.com
> (+47) 986 59 656
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

FWIW, Windows doesn't seem to come with a whole lot, and you need
3rd party software for a number of things, BUT that is also one of the
primary reasons that I need to be able to  quickly get snapshots from
my Git repositories at home, and using zip format is convenient if I am
in an extremely restrictive environment and cannot get a smaller XZ
compressed snapshot :).


--
Mark A Rada (ferrous26)
marada@uwaterloo.ca
