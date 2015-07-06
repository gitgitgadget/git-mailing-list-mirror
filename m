From: Clemens Buchacher <clemens.buchacher@intel.com>
Subject: Re: [PATCH] rebase: return non-zero error code if format-patch fails
Date: Mon, 6 Jul 2015 10:53:26 +0200
Organization: Intel Deutschland GmbH - Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany - Tel: +49 89 99 8853-0, www.intel.de - Managing Directors: Prof. Dr. Hermann Eul, Christin Eisenschmid - Chairperson of the Supervisory Board: Tiffany Doon Silva - Registered Office: Munich - Commercial Register: Amtsgericht Mnchen HRB 186928
Message-ID: <20150706085326.GA30731@musxeris015.imu.intel.com>
References: <20150702091133.GA13353@musxeris015.imu.intel.com> <xmqqpp493z8f.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andrew Wong <andrew.kw.w@gmail.com>,
	Jorge Nunes <jorge.nunes@intel.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 10:53:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZC29j-0006a6-Mx
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 10:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078AbbGFIxc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 04:53:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:21120 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751467AbbGFIx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 04:53:29 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP; 06 Jul 2015 01:53:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,414,1432623600"; 
   d="scan'208";a="756726227"
Received: from musxeris015.imu.intel.com (HELO localhost) ([10.216.40.13])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jul 2015 01:53:26 -0700
Content-Disposition: inline
In-Reply-To: <xmqqpp493z8f.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273378>

On Fri, Jul 03, 2015 at 10:52:32AM -0700, Junio C Hamano wrote:
> >
> > Cc: Andrew Wong <andrew.kw.w@gmail.com>
> > Signed-off-by: Clemens Buchacher <clemens.buchacher@intel.com>
> > Reviewed-by: Jorge Nunes <jorge.nunes@intel.com>
> 
> Where was this review made?  I may have missed a recent discussion,
> and that is why I am asking, because Reviewed-by: lines that cannot
> be validated by going back to the list archive does not add much
> value.

Jorge helped me by reviewing the patch before I submitted it to the
list. My intention is to give credit for his contribution, and to
involve him in any discussion regarding the patch. Maybe it makes more
sense to say Helped-by:? Please feel free to change as you see fit. I
will follow your recommendation in the future.

Thanks.
