From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 03/24] t1430: test the output and error of some commands
 more carefully
Date: Fri, 8 Apr 2016 11:14:19 -0400
Message-ID: <5707CACB.4030906@alum.mit.edu>
References: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
 <1460055791-23313-4-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 17:21:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoYE3-0004YZ-OK
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 17:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758687AbcDHPV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 11:21:26 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:54814 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758599AbcDHPVZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Apr 2016 11:21:25 -0400
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Apr 2016 11:21:25 EDT
X-AuditID: 12074412-52fff700000009f7-63-5707cacce5dd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 2E.BF.02551.CCAC7075; Fri,  8 Apr 2016 11:14:20 -0400 (EDT)
Received: from [10.6.153.201] ([206.71.246.138])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u38FEJ8j007561
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 8 Apr 2016 11:14:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <1460055791-23313-4-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsUixO6iqHvmFHu4wdb5/BbzN51gtOi60s3k
	wOSx4Pl9do/Pm+QCmKK4bZISS8qCM9Pz9O0SuDMe3bnBVtDEUnG87zJTA+NM5i5GTg4JAROJ
	JW9vs3YxcnEICWxllHg1cR4jhLOeSeLJxf9MIFXCArESP680sYPYIgIOEpd3HWWGKGpnlOi4
	vI8VJMEmoCuxqKcZrIFXQFtiSdcZMJtFQEWi5eQGMFtUIERi27pvrBA1ghInZz5h6WLk4OAU
	8JRYM0MIJMwsoCex4/ovVghbXmL72znMExj5ZiHpmIWkbBaSsgWMzKsY5RJzSnN1cxMzc4pT
	k3WLkxPz8lKLdM30cjNL9FJTSjcxQkJPaAfj+pNyhxgFOBiVeHgvvGcLF2JNLCuuzD3EKMnB
	pCTKqwMMXCG+pPyUyozE4oz4otKc1OJDjBIczEoivKkgOd6UxMqq1KJ8mJQ0B4uSOO/Pxep+
	QgLpiSWp2ampBalFMFkZDg4lCV5pkEbBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4
	UOzFFwOjDyTFA7RXHGxvcUFiLlAUovUUoy7Hgh+31zIJseTl56VKifPuOgFUJABSlFGaB7cC
	lmheMYoDfSzM+/0kUBUPMEnBTXoFtIQJaMkFfjaQJSWJCCmpBsaCb+UbM/J742Qm/eGdwLPk
	lk80w6HvAgftl7SLHy3cpxM+vzRfZ2OXQdTuK8Zn8q+evv2Y7/jvEL8z9n+FJm/y+fu4cuGk
	tRO/WjM+9PIImBz1/bzXqeaPck2qU312Wj9ZvbhE9BvH7MDutwsv/9/5xTFqfk5Z 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291038>

On 04/07/2016 03:02 PM, David Turner wrote:
> From: Michael Haggerty <mhagger@alum.mit.edu>
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> [...]

David, even though I wrote these patches, I believe you need to sign
them off too since you are the one submitting them to the list (it's a
chain-of-custody sort of thing).

It's possible Junio would be willing to add the signoffs to the patches
if you tell him "I sign off all of the patches in this series" but I'm
not sure.

Michael
