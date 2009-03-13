From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: Google Summer of Code 2009: GIT
Date: Fri, 13 Mar 2009 11:41:34 +0200
Message-ID: <49BA2A4E.3030506@dawes.za.net>
References: <49B74373.3090609@gmail.com>	 <ab9fa62a0903110655y4a47ccfkde0984ecb46b3307@mail.gmail.com>	 <alpine.DEB.1.00.0903111458340.10498@intel-tinevez-2-302>	 <alpine.DEB.1.10.0903110931070.13653@asgard.lang.hm>	 <ab9fa62a0903111007w4772b234x8e6fd19cdc7fc595@mail.gmail.com>	 <alpine.DEB.1.10.0903111223470.16753@asgard.lang.hm>	 <ab9fa62a0903111302j46c46c2q96af497fa2ac513e@mail.gmail.com>	 <alpine.DEB.1.10.0903111307050.16753@asgard.lang.hm>	 <ab9fa62a0903120542s45b1ceebwddab932891c47cf0@mail.gmail.com>	 <alpine.DEB.1.10.0903121100360.16753@asgard.lang.hm> <ab9fa62a0903121123v35004215hbb64f0ad65399d9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: david@lang.hm, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: saurabh gupta <saurabhgupta1403@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 10:43:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li3v6-0002gu-Rd
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 10:43:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331AbZCMJlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 05:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751964AbZCMJlo
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 05:41:44 -0400
Received: from caiajhbdcaib.dreamhost.com ([208.97.132.81]:52879 "EHLO
	spunkymail-a20.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750935AbZCMJln (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2009 05:41:43 -0400
Received: from artemis.local (unknown [41.246.3.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by spunkymail-a20.g.dreamhost.com (Postfix) with ESMTP id 38308E2501;
	Fri, 13 Mar 2009 02:41:38 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.19 (Macintosh/20081209)
In-Reply-To: <ab9fa62a0903121123v35004215hbb64f0ad65399d9f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113159>

saurabh gupta wrote:
>> exactly. and how you mark the conflict to have it be valid XML is
>> going to depend on details of the type of file. there are probably
>> a few basic methods that will work the vast majority of the time,
>> but with some details needing to be configurable.
>> 
>> for example, if the XML document is a ODF document, it may be
>> possible to add 'revision' tags around the conflict that are
>> already understood by the editor.
> 
> Exactly. This includes the work to modify the xml tags and add 
> contents to represent marker in the best way.

On the XML topic, one last thing to keep in mind is the DTD/XSD which
governs the file.

Rogan
