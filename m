From: Stijn Souffriau <stijn.souffriau@essensium.com>
Subject: rebase --merge question
Date: Sat, 09 Mar 2013 16:15:16 +0100
Message-ID: <513B5204.7080000@essensium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 09 16:15:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UELV4-0004yF-AN
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 16:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410Ab3CIPP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 10:15:27 -0500
Received: from 132.79-246-81.adsl-static.isp.belgacom.be ([81.246.79.132]:54850
	"EHLO viper.mind.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932310Ab3CIPP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 10:15:26 -0500
Received: from [172.16.0.14]
	by viper.mind.be with esmtp (Exim 4.69)
	(envelope-from <stijn.souffriau@essensium.com>)
	id 1UELTy-0000iI-US
	for git@vger.kernel.org; Sat, 09 Mar 2013 16:14:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217728>

Hi all,

 From help rebase:

--merge
	Use merging strategies to rebase. When the recursive (default) merge 
strategy is used, this allows rebase to be aware of renames on the 
upstream side.

Renames of what? Files I assume. Are there any disadvantages compared to 
the normal rebase? If not, why isn't --merge the default behaviour.

Thanks,

Stijn

-- 
Stijn Souffriau
Embedded Software Developer - Mind Embedded Software Division

ESSENSIUM nv
Mind - Embedded Software Division
Gaston Geenslaan 9 - B-3001 Leuven
email : stijn.souffriau@essensium.com
Web: www.essensium.com   /   www.mind.be
BE 872 984 063 RPR Leuven
