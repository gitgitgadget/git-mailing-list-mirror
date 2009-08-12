From: Michael Gaffney <mr.gaffo@gmail.com>
Subject: Re: [ANNOUNCE] Scumd
Date: Wed, 12 Aug 2009 15:56:19 -0500
Message-ID: <4A832C73.3060203@gmail.com>
References: <4A8309D9.8070008@gmail.com> <m3ws58ok1r.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 12 23:27:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbLLm-00020p-PR
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 23:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbZHLV1D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 17:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbZHLV1D
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 17:27:03 -0400
Received: from pp0.asolutions.com ([66.236.120.143]:42934 "EHLO
	pp0.asolutions.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbZHLV1C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 17:27:02 -0400
X-Greylist: delayed 1843 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Aug 2009 17:27:02 EDT
Received: from [192.168.3.65] (mgaffney-l2.asolutions.com [192.168.3.65])
	by pp0.asolutions.com (8.14.1/8.14.1) with ESMTP id n7CKuJdb008696
	for <git@vger.kernel.org>; Wed, 12 Aug 2009 15:56:19 -0500
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
In-Reply-To: <m3ws58ok1r.fsf@localhost.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.8161:2.4.5,1.2.40,4.0.166 definitions=2009-08-12_13:2009-08-11,2009-08-12,2009-08-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0907200000 definitions=main-0908120138
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125750>

Done, thanks.

Jakub Narebski wrote:
> Michael Gaffney <mr.gaffo@gmail.com> writes:
>
>   
>>     This is an initial announcement of SCuMD, a pure java git sshd
>> daemon. The source is at git://github.com/gaffo/scumd. The impetus
>> behind SCuMD is to provide a highly configurable git daemon which can
>> authenticate and authorize off of flat files, databases, LDAP, web
>> services, or any other resource you can think of. SCuMD's other goal
>> is to remove the need to serve off of normal sshd which some find to
>> be a security risk on the open Internet. Currently SCuMD supports LDAP
>> as the authentication module but coding other modules is quite simple.
>>
>>     I would welcome any feedback including a better name. SCuMD stands
>> for SCM Daemon.
>>     
>
> Could you add information about this tool to Git Wiki:
> http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
> perhaps below entry for gitosis?
>
> TIA
>   
