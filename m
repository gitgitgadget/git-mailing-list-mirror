From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: Using a different index and HEAD
Date: Sun, 21 Nov 2010 16:16:15 +0100
Message-ID: <4CE937BF.9010606@dbservice.com>
References: <20101113152906.GA24903@nibiru.local> <m3aaldf863.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Enrico Weigelt <weigelt@metux.de>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 21 16:16:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKBeX-0000XI-6l
	for gcvg-git-2@lo.gmane.org; Sun, 21 Nov 2010 16:16:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116Ab0KUPQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Nov 2010 10:16:24 -0500
Received: from office.neopsis.com ([78.46.209.98]:35010 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753573Ab0KUPQX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Nov 2010 10:16:23 -0500
X-Spam-Status: No, hits=0.0 required=5.0
	tests=AWL: 0.053,BAYES_00: -1.665,TOTAL_SCORE: -1.612,autolearn=ham
X-Spam-Level: 
Received: from calvin.local ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Sun, 21 Nov 2010 16:16:16 +0100
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <m3aaldf863.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161864>

On 11/13/10 6:25 PM, Jakub Narebski wrote:
> Enrico Weigelt<weigelt@metux.de>  writes:
>
>> I'm currently thinking about an IDE toolkit entirely based on git,
>> which eg. versions every single file save operation (so, IOW: an
>> separately versioned workdir) automatically and later allows to
>> rebase/rework this to tell what really gets committed to the
>> actual working branch. For this multiple indices and refs/HEAD
>> pointers would be very helpful.
> UGFWIWNI (Using Git For What It Was Not Intended) ;-) ?

I haven't seen anyone UGFWIINI for in a long time. Either that or my 
perception of 'not intended for' has changed. Maybe we should make a 
second round of the contest and see what use cases people came up with 
since the first UGFWIINI round (it's been almost two years). I'd 
certainly be interested :)

tom
