From: Matt Kraai <kraai@ftbfs.org>
Subject: Re: [PATCH] docs: move submodule section
Date: Wed, 14 Nov 2012 10:50:51 -0800
Message-ID: <20121114185051.GB20412@ftbfs.org>
References: <201211141815.qAEIFTBi017644@netbook1.inf.utfsm.cl>
 <1352918944-26606-1-git-send-email-kraai@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, gitster@pobox.com,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Wed Nov 14 19:51:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYi3H-000762-LJ
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 19:51:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423206Ab2KNSuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 13:50:54 -0500
Received: from kvm.ftbfs.org ([46.22.115.26]:43851 "EHLO kvm.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423016Ab2KNSux (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 13:50:53 -0500
Received: from kraai by kvm.ftbfs.org with local (Exim 4.72)
	(envelope-from <kraai@ftbfs.org>)
	id 1TYi31-0006wG-CM; Wed, 14 Nov 2012 10:50:51 -0800
Mail-Followup-To: git@vger.kernel.org, gitster@pobox.com,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Content-Disposition: inline
In-Reply-To: <1352918944-26606-1-git-send-email-kraai@ftbfs.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209738>

On Wed, Nov 14, 2012 at 10:49:04AM -0800, Matt Kraai wrote:
> 293ab15e ("submodule: teach rm to remove submodules unless they
> contain a git directory", 2012-09-26) inserted the "Submodules"
> section between a sentence describing a command and the command.  Move
> the "Submodules" section further down.
> 
> Signed-off-by: Matt Kraai <kraai@ftbfs.org>

Sorry, I amended the patch to include a Reported-by line but forgot to
reformat it before sending.  It should have included:

 Reported-by: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>

-- 
Matt Kraai
https://ftbfs.org/kraai
