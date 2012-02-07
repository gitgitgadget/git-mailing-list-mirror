From: supadhyay <supadhyay@imany.com>
Subject: Re: User authentication in GIT
Date: Tue, 7 Feb 2012 03:47:42 -0800 (PST)
Message-ID: <1328615262741-7262113.post@n2.nabble.com>
References: <1328595129258-7261349.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 12:47:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RujWW-0000l0-Kb
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 12:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755805Ab2BGLro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 06:47:44 -0500
Received: from sam.nabble.com ([216.139.236.26]:47785 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755328Ab2BGLrn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 06:47:43 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <supadhyay@imany.com>)
	id 1RujWQ-0001sI-OF
	for git@vger.kernel.org; Tue, 07 Feb 2012 03:47:42 -0800
In-Reply-To: <1328595129258-7261349.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190162>

Hi Robin and Jakub,

Thanks for your reply. But I am still not getting what exactly I need to
perform on GIT server. Please find my reply on your suggestion below:


Robin:
All users must have their own SSH key. You do not create keys for them. 
My rely: can you please give some more idea about how it works.. I am not
getting this or if you can provide any link for this to understand.


Jakub:
My reply: existing version control system used  pserver protocol.

You would still need for each user to generate their own SSH key.  
My reply: Do I need to store all end users sSH key in .ssh/authorized_keys
file on GIT server?


--
View this message in context: http://git.661346.n2.nabble.com/User-authentication-in-GIT-tp7261349p7262113.html
Sent from the git mailing list archive at Nabble.com.
