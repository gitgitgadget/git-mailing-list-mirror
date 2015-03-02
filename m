From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH v4 1/2] gitk: write only changed configuration variables
Date: Mon, 2 Mar 2015 22:34:06 +0200
Message-ID: <20150302203406.GA7622@wheezy.local>
References: <1415571602-5858-1-git-send-email-max@max630.net>
 <1415571602-5858-2-git-send-email-max@max630.net>
 <20150301234729.GB24862@iris.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Mar 02 21:41:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSX9W-0003pk-2w
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 21:41:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754896AbbCBUlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 15:41:17 -0500
Received: from p3plsmtpa08-06.prod.phx3.secureserver.net ([173.201.193.107]:60117
	"EHLO p3plsmtpa08-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754502AbbCBUlR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2015 15:41:17 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Mar 2015 15:41:17 EST
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa08-06.prod.phx3.secureserver.net with 
	id yka11p00r5B68XE01ka79z; Mon, 02 Mar 2015 13:34:08 -0700
Content-Disposition: inline
In-Reply-To: <20150301234729.GB24862@iris.ozlabs.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264623>

On Mon, Mar 02, 2015 at 10:47:30AM +1100, Paul Mackerras wrote:
> On Mon, Nov 10, 2014 at 12:20:01AM +0200, Max Kirillov wrote:
>> +		lappend views_modified_names $current_viewname($v)
> 
> This view_modified_names variable doesn't seem to be used anywhere.
> If you don't mind me taking out this line, I'll do that and apply the
> patch.

Yes, sure. Thank you. Must be some editing leftover. I could
not recover what was my intention, even if something
meaningful was ever committed it is rebased and gc-ed
by now.

-- 
Max
