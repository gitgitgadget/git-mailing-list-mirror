From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git clone: very long "resolving deltas" phase
Date: Tue, 06 Apr 2010 17:10:39 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004061709360.7232@xanadu.home>
References: <loom.20100406T161552-321@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Vitaly Berov <vitaly.berov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 23:10:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzG2n-0001n2-OY
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 23:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756769Ab0DFVKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 17:10:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:59167 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756623Ab0DFVKk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 17:10:40 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L0H001ZO45R36C0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 06 Apr 2010 17:10:39 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <loom.20100406T161552-321@post.gmane.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144172>

On Tue, 6 Apr 2010, Vitaly Berov wrote:

> We have quite a large repository and "git clone" takes about 6 hours. Herewith 
> "resolving deltas" takes most of the time.

This simply makes no sense.

Is this repository publicly clonable?


Nicolas
