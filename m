From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH] Modify =?utf-8?b?ZnNja19jb21taXQu?= Replace memcmp by =?utf-8?b?c2tpcF9wcmVmaXg=?=
Date: Sun, 23 Mar 2014 06:08:19 +0000 (UTC)
Message-ID: <loom.20140323T065455-697@post.gmane.org>
References: <1395501132-12894-1-git-send-email-ajha.dev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 23 07:09:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRbb4-0002Ya-Ld
	for gcvg-git-2@plane.gmane.org; Sun, 23 Mar 2014 07:09:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbaCWGIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2014 02:08:49 -0400
Received: from plane.gmane.org ([80.91.229.3]:50945 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750737AbaCWGIs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2014 02:08:48 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WRbaP-0001uh-1i
	for git@vger.kernel.org; Sun, 23 Mar 2014 07:08:45 +0100
Received: from 117.254.218.89 ([117.254.218.89])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 23 Mar 2014 07:08:45 +0100
Received: from tanayabh by 117.254.218.89 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 23 Mar 2014 07:08:45 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 117.254.218.89 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Firefox/24.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244788>

Hi,

Nit: In subject, patch should be like [PATCH v2] for each increasing order
of revision.

Also, after the --- (three dashes), you can write what you changed with each
patch revision. Also to link the previous patches if you can.

So the corrected mail subject header will look something like this,
 
  [PATCH v2] fsck_commit.c: Replace memcmp() by skip_prefix()

Cheers,
Tanay Abhra.
