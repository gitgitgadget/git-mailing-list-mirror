From: Ye Xiaolong <xiaolong.ye@intel.com>
Subject: Re: What's cooking in git.git (Apr 2016, #08; Fri, 29)
Date: Sat, 30 Apr 2016 08:47:41 +0800
Message-ID: <20160430004741.GA16900@yexl-desktop>
References: <xmqq37q4vzp1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 30 02:48:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awJ5c-0001kG-T7
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 02:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650AbcD3Asx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 20:48:53 -0400
Received: from mga09.intel.com ([134.134.136.24]:28358 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752363AbcD3Asw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 20:48:52 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP; 29 Apr 2016 17:48:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,553,1455004800"; 
   d="scan'208";a="965743868"
Received: from yexl-desktop.sh.intel.com (HELO localhost) ([10.239.159.139])
  by orsmga002.jf.intel.com with ESMTP; 29 Apr 2016 17:48:50 -0700
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqq37q4vzp1.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293097>

Hi, Junio

On Fri, Apr 29, 2016 at 03:04:58PM -0700, Junio C Hamano wrote:
>* xy/format-patch-base (2016-04-26) 4 commits
> - format-patch: introduce format.useAutoBase configuration
> - format-patch: introduce --base=auto option
> - format-patch: add '--base' option to record base tree info
> - patch-ids: make commit_patch_id() a public helper function
>
> "git format-patch" learned a new "--base" option to record what
> (public, well-known) commit the original series was built on in
> its output.
>
> Looking close to be ready.
> ($gmane/292622).
>

Not quite sure about this status, anything else I need to do other than
the follow-up patch which to do the enhancement feature suggested by Stefan?

Thanks
