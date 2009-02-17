From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: CVS import [SOLVED]
Date: Tue, 17 Feb 2009 16:16:08 +0100
Message-ID: <499AD4B8.3040505@pelagic.nl>
References: <19651.77.61.241.211.1234775877.squirrel@hupie.xs4all.nl>    <7291.77.61.241.211.1234790434.squirrel@hupie.xs4all.nl>    <60044.192.168.0.51.1234816333.squirrel@hupie.xs4all.nl>    <alpine.DEB.1.00.0902162157080.6289@intel-tinevez-2-302> <50713.77.61.241.211.1234869582.squirrel@hupie.xs4all.nl> <alpine.DEB.1.00.0902171517180.6185@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 17 16:15:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZRf1-00088S-5H
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 16:14:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030AbZBQPMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 10:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753013AbZBQPMm
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 10:12:42 -0500
Received: from hupie.xs4all.nl ([82.95.241.251]:52725 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752196AbZBQPMl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Feb 2009 10:12:41 -0500
Received: from [192.168.0.50] (Paul.internal.Hupie.com [192.168.0.50])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id B4B7658BD88;
	Tue, 17 Feb 2009 16:12:39 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <alpine.DEB.1.00.0902171517180.6185@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110396>

Johannes Schindelin wrote:
> Hi,
>
> On Tue, 17 Feb 2009, Ferry Huberts (Pelagic) wrote:
>
>   
>> 1- correct import, no warnings
>>     
>
> When you say "correct import", do you mean that the import worked, or that 
> the imported file is actually bytewise identical to what is stored in the 
> CVS _repository_ (as opposed to the working directory)?
>
>   
as far as i could tell (but i looked at the checkout, not the 
repository) it means that the files were imported 1:1. no modifications.
(which is actually a bit weird as for some of the cases the autocrlf 
option was set to true or input)

Ferry
