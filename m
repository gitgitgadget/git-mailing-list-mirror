From: "Olsen, Alan R" <alan.r.olsen@intel.com>
Subject: RE: Bugs in Gitosis
Date: Thu, 28 Oct 2010 15:22:19 -0700
Message-ID: <26E9B811E137AB4B95200FD4C950886BA9665E50@orsmsx507.amr.corp.intel.com>
References: <26E9B811E137AB4B95200FD4C950886BA9665D70@orsmsx507.amr.corp.intel.com>
 <vpq8w1if0yy.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Oct 29 00:22:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBarY-0007rj-VM
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 00:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755091Ab0J1WWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 18:22:20 -0400
Received: from mga03.intel.com ([143.182.124.21]:10219 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752140Ab0J1WWT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Oct 2010 18:22:19 -0400
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101.ch.intel.com with ESMTP; 28 Oct 2010 15:22:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.58,254,1286175600"; 
   d="scan'208";a="341855625"
Received: from orsmsx603.amr.corp.intel.com ([10.22.226.49])
  by azsmga001.ch.intel.com with ESMTP; 28 Oct 2010 15:22:17 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.226.213) by
 orsmsx603.amr.corp.intel.com (10.22.226.49) with Microsoft SMTP Server (TLS)
 id 8.2.254.0; Thu, 28 Oct 2010 15:22:17 -0700
Received: from orsmsx507.amr.corp.intel.com ([10.22.226.41]) by
 orsmsx601.amr.corp.intel.com ([10.22.226.213]) with mapi; Thu, 28 Oct 2010
 15:22:16 -0700
Thread-Topic: Bugs in Gitosis
Thread-Index: Act26RKAd0IVVcOtRByyhbTfFjsWSwABT55w
In-Reply-To: <vpq8w1if0yy.fsf@bauges.imag.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160242>

>From: Matthieu Moy [mailto:Matthieu.Moy@grenoble-inp.fr] 
>Sent: Thursday, October 28, 2010 2:43 PM
>To: Olsen, Alan R
>Cc: git@vger.kernel.org
>Subject: Re: Bugs in Gitosis

>"Olsen, Alan R" <alan.r.olsen@intel.com> writes:

>> Here is my list of current outstanding issues with Gitosis.  I do
>> not have fixes for these at the moment, but people and web indexes
>> should be aware of the problems. The author of Gitosis seems to have
>> been taken off-line. (The list may not be complete. I may have
>> forgotten something.)

>For completeness (but I think you know it already): gitolite is an
>alternative to gitosis, and it is maintained.

Does gitolite play well with Gerrit? I note in the docs that it does not react well to files under its control being messed with.
