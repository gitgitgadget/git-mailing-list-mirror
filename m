From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [RFC PATCH v2 1/8] Pass unknown protocols to external protocol
 handlers
Date: Sat, 5 Dec 2009 15:17:44 +0200
Message-ID: <20091205131743.GB1684@Knoppix>
References: <1259942168-24869-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1259942168-24869-4-git-send-email-ilari.liusvaara@elisanet.fi>
 <20091204175545.GC1483@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Dec 05 14:17:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGuWG-0003gl-Hg
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 14:17:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876AbZLENRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 08:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754718AbZLENRl
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 08:17:41 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:57614 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754689AbZLENRk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 08:17:40 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id 7003D13B846;
	Sat,  5 Dec 2009 15:17:46 +0200 (EET)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A01E4C628CA; Sat, 05 Dec 2009 15:17:46 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 60625158A64;
	Sat,  5 Dec 2009 15:17:44 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <20091204175545.GC1483@spearce.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134598>

On Fri, Dec 04, 2009 at 09:55:45AM -0800, Shawn O. Pearce wrote:

<fd dupping code>
 
> This is an entirely unrelated change.  Please split it into its
> own commit so its easier to review, test, blah blah blah.

Moved to 3/8, since that's where it actually will be needed (latter
rearrangement renumbered that patch to 5/8).

-Ilari
