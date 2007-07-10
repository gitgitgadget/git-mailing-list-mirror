From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: [PATCH] Support wholesale directory renames in fast-import
Date: Tue, 10 Jul 2007 10:44:08 +0200
Message-ID: <469346D8.4080906@dawes.za.net>
References: <7154c5c60707091809y7e0b67d5u3f94658b7e814325@mail.gmail.com> <20070710031036.GA9045@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Frech <david@nimblemachines.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 10 10:44:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8BKw-000280-Dx
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 10:44:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757577AbXGJIoo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 04:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756996AbXGJIoo
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 04:44:44 -0400
Received: from sd-green-bigip-177.dreamhost.com ([208.97.132.177]:55955 "EHLO
	spunkymail-a19.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756121AbXGJIon (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jul 2007 04:44:43 -0400
Received: from [192.168.201.103] (dsl-146-24-230.telkomadsl.co.za [165.146.24.230])
	by spunkymail-a19.g.dreamhost.com (Postfix) with ESMTP id 4040C11A13;
	Tue, 10 Jul 2007 01:44:40 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (Windows/20070604)
In-Reply-To: <20070710031036.GA9045@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52055>

Shawn O. Pearce wrote:
> -Zero or more `filemodify`, `filedelete` and `filedeleteall` commands
> +Zero or more `filemodify`, `filedelete`, `filename` and
                                                 ^^ filerename

Rogan
