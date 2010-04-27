From: Mark Rada <marada@uwaterloo.ca>
Subject: Re: [PATCHv2] gitweb: Improve installation instructions in gitweb/INSTALL
Date: Tue, 27 Apr 2010 18:27:39 -0400
Message-ID: <4BD764DB.2020706@mailservices.uwaterloo.ca>
References: <20100427203341.31445.82930.stgit@localhost.localdomain> <4BD74BAB.1040401@mailservices.uwaterloo.ca> <201004272247.27566.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Mark Rada <marada@uwaterloo.ca>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 28 00:27:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6tG0-0008Fx-TO
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 00:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757361Ab0D0W1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 18:27:48 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:33475 "EHLO
	mailchk-m05.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755272Ab0D0W1r (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Apr 2010 18:27:47 -0400
Received: from karakura.local (static-66-225-153-161.ptr.terago.net [66.225.153.161])
	(authenticated bits=0)
	by mailchk-m05.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id o3RMRed8031072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 27 Apr 2010 18:27:41 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <201004272247.27566.jnareb@gmail.com>
X-UUID: aedd23e0-02df-491e-985d-0d1d415c1c41
X-Miltered: at mailchk-m05 with ID 4BD764DC.001 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.96 at mailchk-m05
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m05.uwaterloo.ca [129.97.128.141]); Tue, 27 Apr 2010 18:27:46 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145960>

On 10-04-27 4:47 PM, Jakub Narebski wrote:
> -- To install gitweb to /var/www/cgi-bin/gitweb/ when git wrapper
> -  is installed at /usr/local/bin/git and the repositories (projects)
> -  we want to display are under /home/local/scm, you can do
> +- To install gitweb to /var/www/cgi-bin/gitweb/, when git wrapper
> +  is installed at /usr/local/bin/git, the repositories (projects)
> +  we want to display are under /home/local/scm, and you do not use
> +  minifiers, you can do
>  

To me it looks like a run on sentence, but it doesn't provide redundant
information and leaves a keyword to help jump to the relevant section.

FWIW:

Acked-by: Mark Rada <marada@uwaterloo.ca>



-- 
Mark Rada
marada@uwaterloo.ca
