From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH (revised)] gitweb: Show project's git URL on summary page
Date: Wed, 16 Aug 2006 14:56:22 +0200
Organization: At home
Message-ID: <ebv4jv$fj4$1@sea.gmane.org>
References: <200608152003.05693.jnareb@gmail.com> <200608152303.17994.jnareb@gmail.com> <ebuhjn$kdm$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Aug 16 14:56:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDKwJ-0005HW-Vr
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 14:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWHPM4E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 08:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWHPM4E
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 08:56:04 -0400
Received: from main.gmane.org ([80.91.229.2]:46553 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751159AbWHPM4D (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Aug 2006 08:56:03 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GDKvw-0005B8-Se
	for git@vger.kernel.org; Wed, 16 Aug 2006 14:55:44 +0200
Received: from host-81-190-28-152.torun.mm.pl ([81.190.28.152])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Aug 2006 14:55:44 +0200
Received: from jnareb by host-81-190-28-152.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Aug 2006 14:55:44 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-28-152.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25515>

Aneesh Kumar K.V wrote:


> this can give wrong value is some case with index.aux as projects_list. 
> I have a setup where project details are displayed via gitweb but not
> reachable via http:// url and some reachable via http:// url. 
> 
> For the first one only ssh:// based clone mechanism will work and for 
> the other both will work. How do we handle that

See my "[PATCH 2/2] gitweb: Add support for per project git URLs" in this
thread.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
