From: Martin Atukunda <matlads@dsmagic.com>
Subject: Re: [PATCH 0/4] Repository format version check series.
Date: Tue, 29 Nov 2005 09:42:42 +0300
Message-ID: <20051129064242.GA8978@igloo.ds.co.ug>
References: <7voe48gqg9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Nov 29 08:13:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgzDD-0002wQ-Sf
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 07:43:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbVK2Gna (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 01:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbVK2Gna
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 01:43:30 -0500
Received: from metronet39.infocom.co.ug ([217.113.73.39]:15623 "EHLO
	entandikwa.ds.co.ug") by vger.kernel.org with ESMTP
	id S1751329AbVK2Gna (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2005 01:43:30 -0500
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP id 6DCA25253
	for <git@vger.kernel.org>; Tue, 29 Nov 2005 09:44:36 +0300 (EAT)
Received: from matlads by igloo.ds.co.ug with local (Exim 4.54)
	id 1EgzCM-0002L5-OO
	for git@vger.kernel.org; Tue, 29 Nov 2005 09:42:42 +0300
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7voe48gqg9.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12926>

On Fri, Nov 25, 2005 at 05:15:02PM -0800, Junio C Hamano wrote:
> This series is what I've been cooking for the past several days,
> partly based on patch from Martin Atukunda but with hopefully
> smaller impact.
> 
> [PATCH 1/4] Repository format version check.
> [PATCH 2/4] Check repository format version in enter_repo().
> [PATCH 3/4] init-db: check template and repository format.
> [PATCH 4/4] setup_git_directory(): check repository format version.

This is just to confirm that this patch series passed the tests on my
end. Good work.

- Martin -

-- 
Due to a shortage of devoted followers, the production of great leaders has been discontinued.
