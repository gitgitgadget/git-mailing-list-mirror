From: Pieter de Bie <pieter@frim.nl>
Subject: Re: Importing Bzr revisions
Date: Mon, 23 Mar 2009 20:15:47 +0000
Message-ID: <CF094EC6-72B6-4523-92ED-6582ADC4C1EE@frim.nl>
References: <90DBD254-1810-4B11-AA9F-C5661A028FA5@gmail.com> <7veiwo8xz7.fsf@gitster.siamese.dyndns.org> <03AC7EDA-2A9F-4626-A67B-CE9F2A88FC7D@gmail.com> <4123DB23-39C4-4651-A3B5-C7876A781365@frim.nl> <D05262B5-9B18-49C9-8312-E69926F967AF@gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Reitter <david.reitter@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 21:17:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llqab-0004at-VA
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 21:17:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266AbZCWUQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 16:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753122AbZCWUQJ
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 16:16:09 -0400
Received: from frim.nl ([87.230.85.232]:58402 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752301AbZCWUQJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 16:16:09 -0400
Received: from 82-41-227-224.cable.ubr11.sgyl.blueyonder.co.uk ([82.41.227.224] helo=[192.168.50.100])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pieter@frim.nl>)
	id 1LlqYs-000482-53; Mon, 23 Mar 2009 21:15:54 +0100
In-Reply-To: <D05262B5-9B18-49C9-8312-E69926F967AF@gmail.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114347>


On 23 mrt 2009, at 15:18, David Reitter wrote:

> Could you update the documentation as to how to install the git-bzr  
> script?
> (I searched for "plugin" in the git user manual, and google, and  
> didn't find anything.  I haven't used git much, so I'm a bit naive  
> as regards to such a question.)

There's nothing to install, just call the script.. if you run it  
without commands it should give some usage information. The README in  
the repository should tell the rest. If you'd like to call it using  
'git bzr' rather than 'git-bzr', you have to put it somewhere in your  
PATH
