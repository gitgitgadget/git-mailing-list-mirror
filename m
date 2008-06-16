From: Mike Hommey <mh@glandium.org>
Subject: Re: git-rerere observations and feature suggestions
Date: Mon, 16 Jun 2008 13:09:18 +0200
Organization: glandium.org
Message-ID: <20080616110918.GA30856@glandium.org>
References: <20080616110113.GA22945@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Mon Jun 16 13:11:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8CcO-0007BL-FT
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 13:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbYFPLKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 07:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752061AbYFPLKa
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 07:10:30 -0400
Received: from vuizook.err.no ([194.24.252.247]:48576 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752011AbYFPLK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 07:10:29 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1K8CbK-0006Jr-AD; Mon, 16 Jun 2008 13:10:24 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1K8CaM-00083c-4w; Mon, 16 Jun 2008 13:09:18 +0200
Content-Disposition: inline
In-Reply-To: <20080616110113.GA22945@elte.hu>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85177>

- At least, compress the data in the rr-cache. It can grow big quite
  easily. Also, I wonder if keeping the entire files is not overkill...

Mike
