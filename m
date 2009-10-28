From: David Brown <davidb@quicinc.com>
Subject: Re: [PATCH] commit: More generous accepting of RFC-2822 footer
 lines.
Date: Wed, 28 Oct 2009 11:17:20 -0700
Message-ID: <20091028181720.GA28165@huya.quicinc.com>
References: <20091027234520.GA11433@quaoar.codeaurora.org>
 <20091028171344.GA22290@quaoar.codeaurora.org>
 <7vd447o0jp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Brown <davidb@codeaurora.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 19:17:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3D5T-0004po-6F
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 19:17:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990AbZJ1SRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 14:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752423AbZJ1SRY
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 14:17:24 -0400
Received: from wolverine01.qualcomm.com ([199.106.114.254]:43864 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbZJ1SRY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 14:17:24 -0400
X-IronPort-AV: E=McAfee;i="5300,2777,5784"; a="26303941"
Received: from pdmz-ns-mip.qualcomm.com (HELO numenor.qualcomm.com) ([199.106.114.10])
  by wolverine01.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 Oct 2009 11:17:29 -0700
Received: from msgtransport05.qualcomm.com (msgtransport05.qualcomm.com [129.46.61.150])
	by numenor.qualcomm.com (8.14.2/8.14.2/1.0) with ESMTP id n9SIHTV4011768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
	Wed, 28 Oct 2009 11:17:29 -0700
Received: from huya.quicinc.com (huya.qualcomm.com [10.46.167.38])
	by msgtransport05.qualcomm.com (8.14.2/8.14.2/1.0) with ESMTP id n9SIHO0u017063
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 28 Oct 2009 11:17:25 -0700
Content-Disposition: inline
In-Reply-To: <7vd447o0jp.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131493>

On Wed, Oct 28, 2009 at 11:06:50AM -0700, Junio C Hamano wrote:

> I do not think it is particularly readable to add Cc: at the end, and in a
> sense this patch encourages that practice (without the patch, the end
> result looks ugly and that has an effect to discourage people from adding
> Cc: there).

I wasn't actually even thinking of Cc: at the end.  I was
thinking more of things like Acked-by:, or Bugs-fixed:, or
Patch-applied-even-though-I-dont-like-it-by:, or
like that.

David
