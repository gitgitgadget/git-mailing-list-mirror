From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH v2] t/README: unify documentation of test function args
Date: Tue, 26 Apr 2011 13:30:41 -0400
Message-ID: <1303839041.18603.17.camel@drew-northup.unet.maine.edu>
References: <7vzknei0vn.fsf@alter.siamese.dyndns.org>
	 <1303814006-4109-1-git-send-email-misfire@debugon.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mathias Lafeldt <misfire@debugon.org>
X-From: git-owner@vger.kernel.org Tue Apr 26 19:32:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEm82-0001pV-Jv
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 19:32:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757643Ab1DZRce (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 13:32:34 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:47830 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757288Ab1DZRce (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 13:32:34 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p3QHUkw3026809
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 26 Apr 2011 13:30:52 -0400
In-Reply-To: <1303814006-4109-1-git-send-email-misfire@debugon.org>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=3
	Fuz1=3 Fuz2=3
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p3QHUkw3026809
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1304443863.68348@+MbFjzH7/LZcwfw9nAZJDA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172113>


On Tue, 2011-04-26 at 12:33 +0200, Mathias Lafeldt wrote:

> @@ -389,7 +389,7 @@ library for your script to use.
>  	    'git-write-tree should be able to write an empty tree.' \
>  	    'tree=$(git-write-tree)'
>  
> -   If you supply three parameters the first will be taken to be a
> +   If you supply three parameters, the first will be taken to be a
>     prerequisite, see the test_set_prereq and test_have_prereq
>     documentation below:

As "If you supply three parameters" is not an introductory clause to a
larger complete thought in the following few words, the additional comma
is unnecessary.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
