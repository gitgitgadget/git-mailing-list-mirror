From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Teach "git diff" HTML funcname patterns
Date: Wed, 20 Aug 2008 19:29:40 +0200
Organization: glandium.org
Message-ID: <20080820172940.GA26411@glandium.org>
References: <200808201927.47099.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Aug 20 19:31:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVrWa-0001Ph-0R
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 19:31:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbYHTRaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 13:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751912AbYHTRaI
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 13:30:08 -0400
Received: from vuizook.err.no ([194.24.252.247]:47470 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751020AbYHTRaH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 13:30:07 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1KVrVN-0007y5-HI; Wed, 20 Aug 2008 19:30:03 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1KVrV6-0006sr-EM; Wed, 20 Aug 2008 19:29:40 +0200
Content-Disposition: inline
In-Reply-To: <200808201927.47099.johan@herland.net>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92999>

On Wed, Aug 20, 2008 at 07:27:46PM +0200, Johan Herland wrote:
> Finds lines with <h1>..<h6> tags. The pattern is adapted from the ruby one.

Don't you want to catch <H1>...<H6> too ?

Mike
