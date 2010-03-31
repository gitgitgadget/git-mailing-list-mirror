From: layer <layer@known.net>
Subject: Re: git branch -a prefixes origin/ branches with remotes/
Date: Wed, 31 Mar 2010 10:45:47 -0700
Message-ID: <26340.1270057547@relay.known.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 31 19:45:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nx1zG-00020N-4H
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 19:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757782Ab0CaRps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Mar 2010 13:45:48 -0400
Received: from relay.known.net ([173.13.135.57]:56377 "EHLO relay.known.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757628Ab0CaRps (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 13:45:48 -0400
Received: from localhost (127.0.0.1) by relay.known.net
    (Allegro Maild v1.2.21) id 000000088315; Wed, 31 Mar 2010 10:45:47 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143687>

I should add that the scripts are merely testing for the existence of
remote tracking branches in the local repo.  If there's a better way
to do this, I'm game.  Thanks.

Kevin
