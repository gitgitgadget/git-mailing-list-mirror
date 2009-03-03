From: roylee17 <roylee17@gmail.com>
Subject: Re: [RFC] Add an option for git-archive to output commit ID in
 alternative ways
Date: Tue, 3 Mar 2009 08:51:37 -0800 (PST)
Message-ID: <1236099097541-2416431.post@n2.nabble.com>
References: <1236078904678-2414580.post@n2.nabble.com> <7vtz6ad31f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 17:53:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeXrt-0007UY-EC
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 17:53:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739AbZCCQvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 11:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753093AbZCCQvk
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 11:51:40 -0500
Received: from kuber.nabble.com ([216.139.236.158]:58458 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142AbZCCQvk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 11:51:40 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1LeXqD-0003lI-He
	for git@vger.kernel.org; Tue, 03 Mar 2009 08:51:37 -0800
In-Reply-To: <7vtz6ad31f.fsf@gitster.siamese.dyndns.org>
X-Nabble-From: roylee17@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112118>




Junio C Hamano wrote:
> 
> roylee17 <roylee17@gmail.com> writes:
> 
>> Consider the following use case:
>>   Regularly building projects which are untar'ed on-the-fly with
>> git-archive
>> without intermediate tar balls.
>>
>> How can I track back which commit IDs were those source code git-archive
>> from?
> 
> Run "man gitattributes" and look for export-subst?
> 
> 

Really nice feature, thanks.

-- 
View this message in context: http://n2.nabble.com/-RFC--Add-an-option-for-git-archive-to-output-commit-ID-in-alternative-ways-tp2414580p2416431.html
Sent from the git mailing list archive at Nabble.com.
