From: David Brown <git@davidb.org>
Subject: Re: OSX, ZFS, UTF8, git - somebody hates me in this list
Date: Sun, 4 May 2008 23:52:59 -0700
Message-ID: <20080505065259.GA25070@old.davidb.org>
References: <86wsm9dbhk.fsf@blue.stonehenge.com> <20080504215208.GG29038@spearce.org> <86skwxd97d.fsf@blue.stonehenge.com> <86k5i9d91w.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Mon May 05 08:54:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsuaN-0005wI-Ug
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 08:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692AbYEEGxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 02:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753301AbYEEGxE
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 02:53:04 -0400
Received: from mail.davidb.org ([66.93.32.219]:46193 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670AbYEEGxD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 02:53:03 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.69 #1 (Debian))
	id 1JsuZH-0006YC-VH; Sun, 04 May 2008 23:52:59 -0700
Mail-Followup-To: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <86k5i9d91w.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81234>

On Sun, May 04, 2008 at 03:00:11PM -0700, Randal L. Schwartz wrote:

>Ahh, oddly enough, it does exactly the same on HFS+, but *not* UFS, which is
>why I hadn't noticed it yet, since all of my things I mirror are on my UFS
>partition, just in case they have case-colliding names.

Anyone know if 'case sensitive' HFS+ does name mangling?  Perhaps ZFS can
also be formed as case sensitive.

David
