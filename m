From: Max Kirillov <max@max630.net>
Subject: Re: [BUGFIX/RFC] git-show: fix 'git show -s' to not add extra
 terminator after merge commit
Date: Tue, 13 May 2014 02:26:25 +0300
Message-ID: <20140512232600.GA6857@wheezy.local>
References: <20140511232505.GA29104@wheezy.local>
 <xmqqk39qu96o.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 13 01:26:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjzcA-0005kG-Km
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 01:26:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbaELX0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 19:26:31 -0400
Received: from p3plsmtpa06-09.prod.phx3.secureserver.net ([173.201.192.110]:34892
	"EHLO p3plsmtpa06-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751272AbaELX0a (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 May 2014 19:26:30 -0400
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa06-09.prod.phx3.secureserver.net with 
	id 1BSP1o0083gsSd601BSVfR; Mon, 12 May 2014 16:26:30 -0700
Content-Disposition: inline
In-Reply-To: <xmqqk39qu96o.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248743>

On Mon, May 12, 2014 at 09:59:39AM -0700, Junio C Hamano wrote:
> A good way to double-check may be to see the fixes to the tests to
> correct their wrong expectations, and if the updated expectation is
> sensible.

I have sent the fixes to tests. To me they look sensible.

Also fixed the things you pointed out.

-- 
Max
