From: Mike Hommey <mh@glandium.org>
Subject: git-push --all --tags not allowed?
Date: Mon, 16 Jun 2008 22:34:54 +0200
Organization: glandium.org
Message-ID: <20080616203454.GA31521@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 22:37:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8LRn-0004vH-SP
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 22:37:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753814AbYFPUgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 16:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753665AbYFPUgH
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 16:36:07 -0400
Received: from vuizook.err.no ([194.24.252.247]:60926 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751552AbYFPUgH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 16:36:07 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1K8LQi-0003m9-Bj
	for git@vger.kernel.org; Mon, 16 Jun 2008 22:36:02 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1K8LPi-0008Gq-R1
	for git@vger.kernel.org; Mon, 16 Jun 2008 22:34:54 +0200
Content-Disposition: inline
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85229>

Hi,

Is it a bug that git push --all --tags is not allowed, or is it somehow
a feature ?

Mike
